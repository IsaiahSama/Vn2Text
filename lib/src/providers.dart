import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:io';
import 'package:flutter_sharing_intent/model/sharing_file.dart';

final sharedFileProvider = StateProvider<List<SharedFile>>((ref) => []);
final fileProvider = StateProvider<File?>((ref) => null);
final errorProvider = StateProvider<String>((ref) => "");
final messageProvider = StateProvider<String>((ref) => "");
final nextPathProvider = StateProvider<String>((ref) => "");
final transcriptionProvider = StateProvider<String>((ref) => "");
