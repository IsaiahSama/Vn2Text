import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final clientProvider = StateProvider<Client>((ref) => Client());

class ResponseState {
  ResponseState({required this.success, required this.text});
  bool success;
  String text;
}

class Client {
  // Override / Modify this if need be.
  final Dio client = Dio();
  final String url = dotenv.get("TRANSCRIPTION_URL");
  final String apiKey = dotenv.get("TRANSCRIPTION_API_KEY", fallback: "");

  Future<ResponseState> transcribe(File file) async {
    FormData formData = FormData.fromMap({
      "audio": await MultipartFile.fromFile(file.path),
    });

    try {
      Response response = await client.post(
        url,
        data: formData,
        options: Options(
          headers: {
            "Content-Type": "multipart/form-data",
          },
        ),
      );

      // Check for errors

      var data = response.data;

      // Store the Transcription to the Riverpod

      return ResponseState(success: true, text: data["text"]);
    } on DioException catch (e) {
      if (e.response != null && e.response!.statusCode != 500) {
        return ResponseState(success: false, text: e.response!.data["error"]);
      }
      
      if (e.response != null && e.response!.statusCode == 500) {
        return ResponseState(success: false, text: "An issue occurred with the server for transcriptions.");
      }

      // If there's an error, display it.
      return ResponseState(success: false, text: e.toString());
    }
  }
}