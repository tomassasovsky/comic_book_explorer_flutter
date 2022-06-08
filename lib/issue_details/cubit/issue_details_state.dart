part of 'issue_details_cubit.dart';

/// {@template issue_details_state}
/// Represents the state of the issue details page.
/// {@endtemplate}
abstract class IssueDetailsState extends Equatable {
  /// {@macro issue_details_state}
  const IssueDetailsState();

  @override
  List<Object> get props => [];
}

/// {@template issue_details_initial}
/// Represents the initial state of the issue details page.
/// (nothing is loading, no issue data is available yet)
/// {@endtemplate}
class IssueDetailsInitial extends IssueDetailsState {
  /// {@macro issue_details_initial}
  const IssueDetailsInitial();
}

/// {@template issue_details_fetching}
/// Represents the fetching state of the issue details page.
/// (the issue details are being fetched)
/// {@endtemplate}
class IssueDetailsFetching extends IssueDetailsInitial {
  /// {@macro issue_details_fetching}
  const IssueDetailsFetching();
}

/// {@template issue_details_fetched}
/// Represents the fetched state of the issue details page.
/// (the issue details are available)
/// {@endtemplate}
class IssueDetailsFetched extends IssueDetailsInitial {
  /// {@macro issue_details_fetched}
  const IssueDetailsFetched(
    this.characters,
    this.locations,
    this.teams,
  );

  /// The characters of the issue.
  final List<ComicVineImageResponse> characters;

  /// The locations of the issue.
  final List<ComicVineImageResponse> locations;

  /// The characters of the issue.
  final List<ComicVineImageResponse> teams;

  @override
  List<Object> get props => [
        characters,
        locations,
        teams,
      ];

  @override
  String toString() =>
      // ignore: lines_longer_than_80_chars
      'IssueDetailsFetched(characters: $characters, locations: $locations, teams: $teams)';
}

/// {@template issue_details_error}
/// Represents the error state of the issue details page.
/// (the issue details could not be fetched)
/// {@endtemplate}
class IssueDetailsFailedToFetch extends IssueDetailsInitial {
  /// {@macro issue_details_error}
  /// The error that occurred.
  const IssueDetailsFailedToFetch(this.result);

  /// The result of the error.
  final ComicVineResult result;

  @override
  List<Object> get props => [result];

  @override
  String toString() => 'IssueDetailsFailedToFetch(result: $result)';
}
