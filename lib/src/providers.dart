import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:io';


final fileProvider = StateProvider<File?>((ref) => null);
final errorProvider = StateProvider<String>((ref) => "");
final messageProvider = StateProvider<String>((ref) => "");
final nextPathProvider = StateProvider<String>((ref) => "");
final transcriptionProvider = StateProvider<String>((ref) => "");
