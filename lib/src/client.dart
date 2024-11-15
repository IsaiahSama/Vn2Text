import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:voice_note_to_text/src/providers.dart';

final clientProvider = StateProvider<Client>((ref) => Client(url: ref.watch(localHostURLProvider), apiKey: ref.watch(apiKeyProvider)));

class ResponseState {
  ResponseState({required this.success, required this.text});
  bool success;
  String text;
}

class Client {
  // Override / Modify this if need be.

  Client({required this.url, required this.apiKey});

  final Dio client = Dio();
  final String url;
  final String apiKey;

  Future<ResponseState> transcribe(File file) async {
    FormData formData = FormData.fromMap({
      "audio": await MultipartFile.fromFile(file.path),
    });

    print(url);
    
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