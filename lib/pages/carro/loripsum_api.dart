import 'dart:async';

import 'package:http/http.dart' as http;

class LoripsumApi {
  static Future<String> getLoripsum() async {
    final String url = 'https://loripsum.net/api';
    final response = await http.get(url);
    String text = response.body;

    text = text.replaceAll('<p>', '');
    text = text.replaceAll('</p>', '');

    return text;
  }
}

class LoripsumBloc {
  final _streamController = StreamController<String>();

  static String lorim;

  Stream<String> get stream => _streamController.stream;

  void fetch() async {
    String text = lorim ?? await LoripsumApi.getLoripsum();
    lorim = text;
    _streamController.add(text);
  }

  void dispose() {
    _streamController.close();
  }
}
