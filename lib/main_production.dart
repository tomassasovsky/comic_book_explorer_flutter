import 'package:comic_book_explorer/app/app.dart';
import 'package:comic_vine_api/comic_vine_api.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

Future<void> main() async {
  const apiKey = 'your_api_key_here';

  final apiClient = ComicVineApi(
    apiKey: apiKey,
    httpClient: http.Client(),
  );

  runApp(App(apiClient: apiClient));
}
