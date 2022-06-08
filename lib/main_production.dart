import 'package:comic_book_explorer/app/app.dart';
import 'package:comic_book_explorer/bootstrap.dart';
import 'package:comic_vine_api/comic_vine_api.dart';
import 'package:env_flutter/env_flutter.dart';

import 'package:http/http.dart' as http;

Future<void> main() async {
  await dotenv.load(fileNames: const ['.env']);
  final apiKey = dotenv.env['COMIC_VINE_API_KEY'];
  if (apiKey == null) {
    throw Exception('COMIC_VINE_API_KEY is not set');
  }

  final apiClient = ComicVineApi(
    apiKey: apiKey,
    httpClient: http.Client(),
  );

  await bootstrap(() => App(apiClient: apiClient));
}
