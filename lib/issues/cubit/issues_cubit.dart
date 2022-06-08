import 'package:bloc/bloc.dart';
import 'package:comic_vine_api/comic_vine_api.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'issues_state.dart';

/// {@template issues_cubit}
/// Represents the cubit of the issues page.
/// {@endtemplate}
class IssuesCubit extends Cubit<IssuesState> {
  /// {@macro issues_cubit}
  IssuesCubit({
    required ComicVineApi comicVineApi,
  })  : _comicVineApi = comicVineApi,
        super(const IssuesInitial());

  /// {@macro issues_cubit_get_issues}
  Future<void> getIssues() async {
    if (state is IssuesFetching) return;

    emit(const IssuesFetching());

    var offset = 0;

    final currentState = state;
    if (currentState is IssuesFetched) {
      offset = currentState.offset;
    }

    try {
      // TODO(tomassasovsky): Add pagination.
      final result = await _comicVineApi.getIssues(
        offset: offset,
      );
      if (result.result != ComicVineResult.ok) {
        emit(IssuesFailedToFetch(result.result));
      }

      emit(
        IssuesFetched(
          issues: result.items,
          canLoadMore: result.totalResults > result.items.length,
        ),
      );
    } catch (_) {
      // TODO(tomassasovsky): Handle different errors
      emit(
        const IssuesFailedToFetch(ComicVineResult.unknownError),
      );
    }
  }

  final ComicVineApi _comicVineApi;
}
