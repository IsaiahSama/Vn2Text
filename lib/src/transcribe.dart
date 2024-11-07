import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import './providers.dart';

class TranscriptionPage extends ConsumerWidget {
  const TranscriptionPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String transcription = ref.watch(transcriptionProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Transcription"),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go("/"),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle_outlined),
            onPressed: () => context.go("/"),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
            transcription == "" ? "No transcription yet..." : transcription,
            textAlign: TextAlign.justify),
      ),
    );
  }
}
