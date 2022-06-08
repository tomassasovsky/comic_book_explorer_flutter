import 'package:bloc/bloc.dart';
import 'package:comic_book_explorer/utils/comic_vine_id_from_string_url.dart';
import 'package:comic_vine_api/comic_vine_api.dart';
import 'package:equatable/equatable.dart';

part 'issue_details_state.dart';

/// {@template issue_details_cubit}
/// Represents the cubit of the issue details page.
/// {@endtemplate}
class IssueDetailsCubit extends Cubit<IssueDetailsState> {
  /// {@macro issue_details_cubit}
  IssueDetailsCubit({
    required ComicVineApi comicVineApi,
    required String issueId,
  })  : _comicVineApi = comicVineApi,
        _issueId = issueId,
        super(const IssueDetailsInitial());

  /// Gets the issue details
  Future<void> fetchIssueDetails() async {
    try {
      if (state is IssueDetailsFetching) return;

      final response = await _comicVineApi.getIssueDetails(_issueId);
      final issue = response.items.first;

      final charactersFetcher =
          (issue.characterCredits ?? []).map((characterCredits) {
        final id = characterCredits.apiDetailUrl.comicVineId;
        return _comicVineApi.getImage(ComicVineImageResource.character, id!);
      });

      final locationsFetcher =
          (issue.locationCredits ?? []).map((locationCredits) {
        final id = locationCredits.apiDetailUrl.comicVineId;
        return _comicVineApi.getImage(ComicVineImageResource.location, id!);
      });

      final teamsFetcher = (issue.teamCredits ?? []).map((teamCredits) {
        final id = teamCredits.apiDetailUrl.comicVineId;
        return _comicVineApi.getImage(ComicVineImageResource.team, id!);
      });

      final charactersResponse =
          await Future.wait<ComicVineGenericResponse<ComicVineImageResponse>>(
        charactersFetcher,
      );

      final locationsResponse =
          await Future.wait<ComicVineGenericResponse<ComicVineImageResponse>>(
        locationsFetcher,
      );

      final teamsResponse =
          await Future.wait<ComicVineGenericResponse<ComicVineImageResponse>>(
        teamsFetcher,
      );

      emit(
        IssueDetailsFetched(
          charactersResponse
              .map((characters) => characters.items.first)
              .toList(),
          locationsResponse.map((locations) => locations.items.first).toList(),
          teamsResponse.map((teams) => teams.items.first).toList(),
        ),
      );
    } catch (e) {
      // TODO(tomassasovsky): handle error
      emit(
        const IssueDetailsFailedToFetch(
          ComicVineResult.unknownError,
        ),
      );
    }
  }

  final ComicVineApi _comicVineApi;
  final String _issueId;
}
