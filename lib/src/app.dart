import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:voice_note_to_text/src/filepicker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('Voice Note to Text')),
        ),
        body: const MyHomePage(),
      ),
    );
  }
}

final fileProvider = StateProvider<File?>((ref) => null);
final errorProvider = StateProvider<String>((ref) => "");

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
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
                onPressed: () => transcribe(ref),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                ),
                child: const Text("Transcribe!"),
              ))
        ],
      ),
    );
  }
}

void uploadVoiceNote(WidgetRef ref) async {
  print("Upload Voice Note");

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
}

void transcribe(WidgetRef ref) async {
  print("Transcribe!");

  // Transcribe the file using my API

  // Display the transcription. Be sure to not store it.

  // If there's an error, display it.
}
