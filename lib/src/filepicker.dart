import 'package:file_picker/file_picker.dart';

class FilePickerHelper {
  static Future<FilePickerResult?> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.audio,
      allowedExtensions: ['opus', 'mpeg', 'mp3', 'ogg'],
    );
    return result;
  }
}
