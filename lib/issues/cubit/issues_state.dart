part of 'issues_cubit.dart';

@immutable

/// {@template issues_state}
/// Represents the state of the issues page.
/// {@endtemplate}
abstract class IssuesState extends Equatable {
  /// {@macro game_state}
  const IssuesState();

  @override
  List<Object> get props => [];
}

/// {@template issues_initial}
/// Represents the initial state of the issues page.
/// (nothing is loading, no issues are available)
/// {@endtemplate}
class IssuesInitial extends IssuesState {
  /// {@macro issues_initial}
  const IssuesInitial();
}

/// {@template issues_fetching}
/// Represents the fetching state of the issues page.
/// (the issues are being fetched)
/// {@endtemplate}
class IssuesFetching extends IssuesState {
  /// {@macro issues_fetching}
  const IssuesFetching();
}

/// {@template issues_fetched}
/// Represents the fetched state of the issues page.
/// (the issues are available)
/// {@endtemplate}
class IssuesFetched extends IssuesState {
  /// {@macro issues_fetched}
  const IssuesFetched({
    required this.issues,
    required this.canLoadMore,
  });

  /// The available issues.
  final List<ComicVineIssue> issues;

  /// Whether more issues can be loaded.
  final bool canLoadMore;

  /// This will determine the starting index of the next page.
  int get offset => issues.length;

  @override
  List<Object> get props => [issues, canLoadMore];

  @override
  String toString() =>
      'IssuesFetched(issues: $issues, canLoadMore: $canLoadMore)';
}

/// {@template issues_error}
/// Represents the error state of the issues page.
/// (the issues could not be fetched)
/// {@endtemplate}
class IssuesFailedToFetch extends IssuesState {
  /// {@macro issues_error}
  /// The error that occurred.
  const IssuesFailedToFetch(
    this.result,
    this.error,
  );

  /// The result of the error.
  final ComicVineResult result;

  /// The error that occurred.
  final String error;

  @override
  List<Object> get props => [
        result,
        error,
      ];

  @override
  String toString() => 'IssuesFailedToFetch(result: $result)';
}
