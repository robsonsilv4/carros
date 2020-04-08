import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:path/path.dart' as path;

import './http_helper.dart' as http;
import '../pages/api_response.dart';

class UploadService {
  static Future<ApiResponse<String>> upload(File file) async {
    try {
      // FirebaseService.uploadFirebaseStorage(file);

      String url = "https://carros-springboot.herokuapp.com/api/v1/upload";

      List<int> imageBytes = file.readAsBytesSync();
      String base64Image = base64Encode(imageBytes);

      String fileName = path.basename(file.path);

      var params = {
        "fileName": fileName,
        "mimeType": "image/jpeg",
        "base64": base64Image
      };

      String json = jsonEncode(params);

      print("http.upload: " + url);
      print("params: " + json);

      final response = await http
          .post(
            url,
            body: json,
          )
          .timeout(
            Duration(seconds: 30),
            onTimeout: _onTimeOut,
          );

      print("http.upload << " + response.body);

      Map<String, dynamic> map = jsonDecode(response.body);

      String urlFoto = map["url"];

      return ApiResponse.ok(result: urlFoto);
    } catch (error) {
      print(error);
      return ApiResponse.error(message: 'Não foi possível fazer o upload.');
    }
  }

  static FutureOr<Response> _onTimeOut() {
    print("timeout!");
    throw SocketException("Não foi possível se comunicar com o servidor.");
  }
}
