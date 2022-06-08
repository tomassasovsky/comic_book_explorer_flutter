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
              issue: state.issue,
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
    required this.issue,
    required this.characters,
    required this.locations,
    required this.teams,
  });

  final String? imageUrl;
  final ComicVineIssue issue;
  final Iterable<ComicVineImageResponse> characters;
  final Iterable<ComicVineImageResponse> locations;
  final Iterable<ComicVineImageResponse> teams;

  @override
  Widget build(BuildContext context) {
    final _imageUrl = imageUrl;

    return LayoutBuilder(
      builder: (context, constraints) {
        final children = [
          IssueDetailsSectionWidget(
            items: characters,
            title: context.l10n.characters,
          ),
          IssueDetailsSectionWidget(
            items: locations,
            title: context.l10n.locations,
          ),
          IssueDetailsSectionWidget(
            items: teams,
            title: context.l10n.teams,
          ),
        ];

        // web or desktop layout
        if (constraints.maxWidth > 600) {
          return _IssueDetailsFetchedBodyWeb(
            imageUrl: _imageUrl,
            children: children,
          );
        }

        // mobile layout
        return _IssueDetailsFetchedBodyMobile(
          issue: issue,
          imageUrl: _imageUrl,
          appbarMaxHeight: constraints.maxHeight * 0.8,
          children: children,
        );
      },
    );
  }
}

class _IssueDetailsFetchedBodyWeb extends StatelessWidget {
  const _IssueDetailsFetchedBodyWeb({
    required this.children,
    required this.imageUrl,
  });

  final List<IssueDetailsSectionWidget> children;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    final _imageUrl = imageUrl;
    return Row(
      children: [
        Expanded(
          child: ListView(
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: BackButton(),
                ),
              ),
              ...children,
            ],
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
}

class _IssueDetailsFetchedBodyMobile extends StatelessWidget {
  const _IssueDetailsFetchedBodyMobile({
    required this.issue,
    required this.children,
    required this.imageUrl,
    required this.appbarMaxHeight,
  });

  final ComicVineIssue issue;
  final List<IssueDetailsSectionWidget> children;
  final String? imageUrl;
  final double appbarMaxHeight;

  @override
  Widget build(BuildContext context) {
    final _imageUrl = imageUrl;

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: appbarMaxHeight,
          flexibleSpace: FlexibleSpaceBar(
            centerTitle: true,
            titlePadding: EdgeInsets.zero,
            title: _SliverAppBarTitle(issue: issue),
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
  }
}

class _SliverAppBarTitle extends StatelessWidget {
  const _SliverAppBarTitle({
    required this.issue,
  });

  final ComicVineIssue issue;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [
                0.7,
                1.0,
              ],
              colors: [
                Colors.transparent,
                Colors.black54,
              ],
            ),
          ),
          child: SizedBox.expand(),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Text(
            '${issue.name ?? ''} #${issue.issueNumber ?? ''}',
          ),
        ),
      ],
    );
  }
}
