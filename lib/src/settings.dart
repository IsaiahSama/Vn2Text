import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:voice_note_to_text/src/providers.dart';

final localApiKeyProvider = StateProvider<String>((ref) => "");
final localLocalHostURLProvider = StateProvider<String>((ref) => "");

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Settings"),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                children: [
                  const Text("Set API Key"),
                  TextField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'API Key',
                    ),
                    onChanged: (value) => ref.read(localApiKeyProvider.notifier).state = value,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                children: [
                  const Text("Set Localhost URL"),
                  TextField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Transcribe Endpoint',
                    ),
                    onChanged: (value) => ref.read(localLocalHostURLProvider.notifier).state = value,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      String apiKey = ref.read(localApiKeyProvider);
                      String localHostURL = ref.read(localLocalHostURLProvider);

                      if (apiKey.isNotEmpty){
                        ref.read(apiKeyProvider.notifier).state = apiKey;
                      }

                      if(localHostURL.isNotEmpty){
                        ref.read(localHostURLProvider.notifier).state = localHostURL;
                      }

                      context.go("/");
                    },
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                    child: const Text("Update Settings!", style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
