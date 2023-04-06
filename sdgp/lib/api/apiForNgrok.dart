import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class Api {
  static getPredict(File selectedImage) async {
    final request = http.MultipartRequest(
        "POST", Uri.parse("https://d207-212-104-225-198.in.ngrok.io/upload"));
    final headers = {'Content-Type': 'multipart/form-data'};

    request.files.add(
      http.MultipartFile(
        'imageDetect',
        selectedImage.readAsBytes().asStream(),
        selectedImage.lengthSync(),
        filename: selectedImage.path
            .split("/")
            .last,
      ),
    );

    request.headers.addAll(headers);
    final response = await request.send();
    final resString = await response.stream.bytesToString();
    final resJson = jsonDecode(resString);

    return resJson;
  }
}