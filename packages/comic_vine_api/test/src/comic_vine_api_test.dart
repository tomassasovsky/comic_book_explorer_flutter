import 'package:comic_vine_api/comic_vine_api.dart';
import 'package:http/http.dart' as http;
import 'package:test/test.dart';

void main() {
  group('ComicVineApi', () {
    test('can be instantiated', () {
      expect(
        ComicVineApi(
          apiKey: '',
          httpClient: http.Client(),
        ),
        isNotNull,
      );
    });
  });
}
