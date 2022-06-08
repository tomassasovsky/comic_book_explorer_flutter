import 'package:comic_book_explorer/issue_details/issue_details.dart';
import 'package:comic_book_explorer/l10n/l10n.dart';
import 'package:comic_vine_api/comic_vine_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template issue_details_page}
/// The page that displays an issue's details.
/// {@endtemplate}
class IssueDetailsPage extends StatelessWidget {
  /// {@macro issue_details_page}
  const IssueDetailsPage({
    required this.issueId,
    required this.imageUrl,
    super.key,
  });

  /// The ID of the issue to display.
  final String issueId;

  /// The url of the image of the issue.
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => IssueDetailsCubit(
        comicVineApi: context.read<ComicVineApi>(),
        issueId: issueId,
      ),
      child: IssuesView(imageUrl),
    );
  }
}

/// {@template issue_details_view}
/// The page that displays an issue's details.
///
/// WARNING: This should not be used directly.
/// It is intended to be used by the [IssueDetailsPage] widget.
/// {@endtemplate}
class IssuesView extends StatelessWidget {
  /// {@macro issue_details_view}
  const IssuesView(
    this.imageUrl, {
    super.key,
  });

  /// The url of the image of the issue.
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<IssueDetailsCubit, IssueDetailsState>(
        builder: (context, state) {
          if (state is IssueDetailsInitial) {
            context.read<IssueDetailsCubit>().fetchIssueDetails();
          }

          if (state is IssueDetailsFailedToFetch) {
            return Center(
              child: Text(
                context.l10n.failedToFetchIssueDetails,
              ),
            );
          } else if (state is IssueDetailsFetched) {
            return _IssueDetailsFetchedBody(
              imageUrl: imageUrl,
              characters: state.characters,
              locations: state.locations,
              teams: state.teams,
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

class _IssueDetailsFetchedBody extends StatelessWidget {
  const _IssueDetailsFetchedBody({
    required this.imageUrl,
    required this.characters,
    required this.locations,
    required this.teams,
  });

  final String? imageUrl;
  final Iterable<ComicVineImageResponse> characters;
  final Iterable<ComicVineImageResponse> locations;
  final Iterable<ComicVineImageResponse> teams;

  @override
  Widget build(BuildContext context) {
    final _imageUrl = imageUrl;

    return LayoutBuilder(
      builder: (context, constraints) {
        final children = [
          if (characters.isNotEmpty)
            IssueDetailsSectionWidget(
              items: characters,
              title: context.l10n.characters,
            ),
          if (locations.isNotEmpty)
            if (locations.isNotEmpty)
              IssueDetailsSectionWidget(
                items: locations,
                title: context.l10n.locations,
              ),
          if (teams.isNotEmpty)
            IssueDetailsSectionWidget(
              items: teams,
              title: context.l10n.teams,
            ),
        ];

        // web or desktop layout
        if (constraints.maxWidth > 600) {
          return Row(
            children: [
              Expanded(
                child: Column(
                  children: children,
                ),
              ),
              if (_imageUrl != null)
                Image.network(
                  _imageUrl,
                  fit: BoxFit.cover,
                ),
            ],
          );
        }

        // mobile layout
        return CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: constraints.maxHeight * 0.8,
              flexibleSpace: FlexibleSpaceBar(
                background: (_imageUrl != null)
                    ? Image.network(
                        _imageUrl,
                        fit: BoxFit.cover,
                      )
                    : const SizedBox.shrink(),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                children,
              ),
            ),
          ],
        );
      },
    );
  }
}
