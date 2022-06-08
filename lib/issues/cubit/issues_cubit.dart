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

    _safeEmit(const IssuesFetching());

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
        _safeEmit(
          IssuesFailedToFetch(
            result.result,
            result.error,
          ),
        );
        return;
      }

      _safeEmit(
        IssuesFetched(
          issues: result.items,
          canLoadMore: result.totalResults > result.items.length,
        ),
      );
    } catch (e) {
      _safeEmit(
        IssuesFailedToFetch(
          ComicVineResult.unknownError,
          e.toString(),
        ),
      );
    }
  }

  void _safeEmit(IssuesState state) {
    if (isClosed) return;
    emit(state);
  }

  final ComicVineApi _comicVineApi;
}
