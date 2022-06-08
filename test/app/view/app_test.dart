import 'package:comic_book_explorer/app/app.dart';
import 'package:comic_book_explorer/issues/issues.dart';
import 'package:comic_vine_api/comic_vine_api.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:http/http.dart' as http;

void main() {
  group('App', () {
    testWidgets('renders IssuesPage', (tester) async {
      const apiKey = 'your_api_key_here';

      final apiClient = ComicVineApi(
        apiKey: apiKey,
        httpClient: http.Client(),
      );

      await tester.pumpWidget(App(apiClient: apiClient));
      expect(find.byType(IssuesPage), findsOneWidget);
    });
  });
}
