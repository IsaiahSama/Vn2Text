import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class FilePickerHelper {

  static Future<FilePickerResult?> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    return result;
  }

}