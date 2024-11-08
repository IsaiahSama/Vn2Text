import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:io';

final clientProvider = StateProvider<Client>((ref) => Client());

class ResponseState {
  ResponseState({required this.success, required this.text});
  bool success;
  String text;
}

class Client {
  // Override / Modify this if need be.
  final Dio client = Dio();
  final String baseUrl = "http://localhost:5000/";

  Future<ResponseState> transcribe(File file) async {
    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(file.path),
    });

    try {
      Response response = await client.post(
        "$baseUrl/transcribe",
        data: formData,
        options: Options(
          headers: {
            "Content-Type": "multipart/form-data",
          },
        ),
      );

      // Check for errors

      var data = response.data;

      if (response.statusCode != 200 || data["error"] != "") {
        return ResponseState(success: false, text: data["error"]);
      }

      // Store the Transcription to the Riverpod

      return ResponseState(success: true, text: data["text"]);
    } catch (e) {
      // If there's an error, display it.
      return ResponseState(success: false, text: e.toString());
    }
  }
}