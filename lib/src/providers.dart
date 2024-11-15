import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:io';
import 'package:flutter_sharing_intent/model/sharing_file.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';


final sharedFileProvider = StateProvider<List<SharedFile>>((ref) => []);
final fileProvider = StateProvider<File?>((ref) => null);
final errorProvider = StateProvider<String>((ref) => "");
final messageProvider = StateProvider<String>((ref) => "");
final nextPathProvider = StateProvider<String>((ref) => "");
final transcriptionProvider = StateProvider<String>((ref) => "");
final localHostURLProvider = StateProvider<String>((ref) => dotenv.get("TRANSCRIPTION_URL"));
final apiKeyProvider = StateProvider<String>((ref) => dotenv.get("TRANSCRIPTION_API_KEY", fallback: ""));