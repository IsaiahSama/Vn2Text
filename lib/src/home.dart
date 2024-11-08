import 'package:file_picker/file_picker.dart';
import 'package:voice_note_to_text/src/client.dart';
import 'package:voice_note_to_text/src/filepicker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import './providers.dart';
import 'package:go_router/go_router.dart';

final loadingProvider = StateProvider<bool>((ref) => false);

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String nextPath = ref.watch(nextPathProvider);

    if (nextPath != "") {
      Future.delayed(Duration.zero, () {
        context.go(nextPath);
        ref.read(nextPathProvider.notifier).state = "";
      });
    }

    bool isLoading = ref.watch(loadingProvider);
    final files = ref.watch(sharedFileProvider);

    // This is for if the platform is Android, and we received a file via sharing.
    if (Platform.isAndroid && files.isNotEmpty) {
      Future.delayed(
        Duration.zero,
        () {
          ref.read(fileProvider.notifier).state =
              File.fromUri(Uri.parse(files[0].value!));
          ref.read(sharedFileProvider.notifier).state = [];
          ref.read(errorProvider.notifier).state = "";
          transcribe(context, ref);
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Voice Note to Text')),
      ),
      body: Center(
        child: Column(
          children: [
            Image.network(
                "https://th.bing.com/th/id/OIG2.DY4RCeB1fLi1yzfYWYzq?pid=ImgGn",
                height: 100,
                width: 100),
            Text(ref.watch(errorProvider).toString(),
                style: const TextStyle(
                  color: Colors.red,
                )),
            Text(ref.watch(messageProvider).toString(),
                style: const TextStyle(
                  color: Colors.green,
                )),
            Padding(
              padding: const EdgeInsets.all(10),
              child: ElevatedButton(
                onPressed: () => uploadVoiceNote(ref),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
                child: const Text("Upload Voice Note"),
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(10),
                child: ElevatedButton(
                  onPressed: () => transcribe(context, ref),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                  ),
                  child: isLoading
                      ? const CircularProgressIndicator()
                      : const Text("Transcribe!"),
                ))
          ],
        ),
      ),
    );
  }

  void uploadVoiceNote(WidgetRef ref) async {
    ref.read(errorProvider.notifier).state = "";
    ref.read(messageProvider.notifier).state = "";

    // Select a file
    FilePickerResult? result = await FilePickerHelper.pickFile();
    // If the file doesn't exist, notify user and return.
    if (result == null) {
      // Display Error message
      ref.read(errorProvider.notifier).state = "No file selected";
      return;
    }

    // Temporarily store the file for transcription.

    File file = File(result.files.single.path!);

    // Store file in Riverpod!
    ref.read(fileProvider.notifier).state = file;

    // Display Success message
    ref.read(messageProvider.notifier).state = "File uploaded!";
  }

  void transcribe(BuildContext context, WidgetRef ref) async {
    ref.read(errorProvider.notifier).state = "";
    ref.read(messageProvider.notifier).state = "";

    if (ref.read(loadingProvider)) {
      ref.read(errorProvider.notifier).state = "Already Transcribing...";
      return;
    }

    // Acquire the file from Riverpod
    File? file = ref.read(fileProvider);

    if (file == null) {
      ref.read(errorProvider.notifier).state = "No file selected";
      return;
    }

    ref.read(loadingProvider.notifier).state = true;
    // Transcribe the file using my API
    Client client = ref.read(clientProvider);

    ResponseState state = await client.transcribe(file);

    if (state.success) {
      // Store the Transcription to the Riverpod
      ref.read(transcriptionProvider.notifier).state = state.text;
      ref.read(nextPathProvider.notifier).state = "/transcribe";
    } else {
      // If there's an error, display it.
      ref.read(errorProvider.notifier).state = state.text;
    }

    ref.read(loadingProvider.notifier).state = false;
  }
}
