import 'package:flutter/material.dart';

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
    ));
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Image.network(
              "https://th.bing.com/th/id/OIG2.DY4RCeB1fLi1yzfYWYzq?pid=ImgGn",
              height: 100,
              width: 100),
          Padding(
            padding: const EdgeInsets.all(10),
            child: ElevatedButton(
              onPressed: uploadVoiceNote,
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
                onPressed: transcribe,
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

void uploadVoiceNote() {

  print("Upload Voice Note");

  // Select a file

  // If the file doesn't exist, notify user and return.

  // Ensure File is of correct format (audio)

  // Temporarily store the file for transcription.

  // Display any errors if there are any.
}

void transcribe() {

  print("Transcribe!");

  // Transcribe the file using my API

  // Display the transcription. Be sure to not store it.

  // If there's an error, display it.
}

