import 'package:comic_book_explorer/issue_details/view/issue_details_page.dart';
import 'package:comic_book_explorer/issues/issues.dart';
import 'package:comic_book_explorer/l10n/l10n.dart';
import 'package:comic_vine_api/comic_vine_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

/// {@template app}
/// The entry point for the application.
/// {@endtemplate}
class App extends StatefulWidget {
  /// {@macro app}
  const App({
    super.key,
    required this.apiClient,
  });

  /// The API client used to fetch data from the Comic Vine API.
  final ComicVineApi apiClient;

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final GoRouter goRouter;

  @override
  void initState() {
    super.initState();
    goRouter = getRouter();
  }

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => widget.apiClient,
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routeInformationParser: goRouter.routeInformationParser,
        routerDelegate: goRouter.routerDelegate,
        theme: ThemeData(
          scaffoldBackgroundColor: const Color(0xfff2f2f2),
          appBarTheme: const AppBarTheme(
            color: Color(0xfff2f2f2),
            titleTextStyle: TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
            elevation: 1,
          ),
          chipTheme: const ChipThemeData(
            padding: EdgeInsets.symmetric(horizontal: 8),
            backgroundColor: Color(0xfff2f2f2),
            selectedColor: Colors.lightGreen,
            labelStyle: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
      ),
    );
  }

  GoRouter getRouter() {
    return GoRouter(
      urlPathStrategy: UrlPathStrategy.path,
      routes: <GoRoute>[
        GoRoute(
          path: '/',
          name: 'home',
          builder: (_, state) => IssuesPage(key: state.pageKey),
        ),
        GoRoute(
          path: '/issue/:id',
          name: 'issue-details',
          builder: (_, state) {
            final id = state.params['id'];
            String? imageUrl;
            if (id == null) throw ArgumentError('Missing issue id');
            try {
              final extra = state.extra as Map<String, dynamic>?;
              imageUrl = extra?['imageUrl'] as String?;
            } catch (_) {}

            return IssueDetailsPage(
              key: state.pageKey,
              issueId: id,
              imageUrl: imageUrl,
            );
          },
        ),
      ],
    );
  }
}
