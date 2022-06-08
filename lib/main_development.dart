import 'package:comic_book_explorer/app/app.dart';
import 'package:comic_book_explorer/bootstrap.dart';
import 'package:comic_vine_api/comic_vine_api.dart';
import 'package:dotenv/dotenv.dart';

import 'package:http/http.dart' as http;

void main() {
  final dotEnv = DotEnv()..load();
  final apiKey = dotEnv['COMIC_VINE_API_KEY'];
  if (apiKey == null) {
    throw Exception('COMIC_VINE_API_KEY is not set');
  }

  final apiClient = ComicVineApi(
    apiKey: apiKey,
    httpClient: http.Client(),
  );

  bootstrap(() => App(apiClient: apiClient));
}
