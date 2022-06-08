import 'package:comic_book_explorer/issues/issues.dart';
import 'package:comic_book_explorer/issues/widgets/issue_overview_widget.dart';
import 'package:comic_book_explorer/l10n/l10n.dart';
import 'package:comic_vine_api/comic_vine_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// {@template issues_page}
/// The page that displays the issues in a paginated manner.
/// Can display the issues in a list or a grid.
/// {@endtemplate}
class IssuesPage extends StatelessWidget {
  /// {@macro issues_page}
  const IssuesPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => IssuesCubit(
        comicVineApi: context.read<ComicVineApi>(),
      ),
      child: const IssuesView(),
    );
  }
}

/// {@template issues_view}
/// The view that displays the issues in a paginated manner.
/// Can display the issues in a list or a grid.
///
/// WARNING: This should not be used directly.
/// It is intended to be used by the [IssuesPage] widget.
/// {@endtemplate}
class IssuesView extends StatefulWidget {
  /// {@macro issues_view}
  const IssuesView({
    super.key,
  });

  @override
  State<IssuesView> createState() => _IssuesViewState();
}

class _IssuesViewState extends State<IssuesView> {
  /// The currently selected view type.
  IssuesViewType selectedView = IssuesViewType.list;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: BlocBuilder<IssuesCubit, IssuesState>(
        builder: (context, state) {
          if (state is IssuesInitial) {
            context.read<IssuesCubit>().getIssues();
          }

          if (state is IssuesFailedToFetch) {
            return Center(
              child: Text(
                context.l10n.failedToFetchIssues,
              ),
            );
          } else if (state is IssuesFetched) {
            return _IssuesViewBody(
              issues: state.issues,
              selectedView: selectedView,
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      title: Text(context.l10n.latestIssuesTitle),
      actions: <Widget>[
        ChoiceChip(
          label: Text(context.l10n.listViewType),
          avatar: const Icon(
            Icons.list,
            color: Colors.black,
          ),
          selected: selectedView == IssuesViewType.list,
          onSelected: (_) {
            setState(() {
              selectedView = IssuesViewType.list;
            });
          },
        ),
        const SizedBox(width: 16),
        ChoiceChip(
          label: Text(context.l10n.gridViewType),
          avatar: const Icon(
            Icons.grid_3x3,
            color: Colors.black,
          ),
          selected: selectedView == IssuesViewType.grid,
          onSelected: (_) {
            setState(() {
              selectedView = IssuesViewType.grid;
            });
          },
        ),
        const SizedBox(width: 16),
      ],
    );
  }
}

class _IssuesViewBody extends StatelessWidget {
  const _IssuesViewBody({
    required this.issues,
    required this.selectedView,
  });

  /// The currently selected view type.
  final IssuesViewType selectedView;

  /// The issues to display.
  final List<ComicVineIssue> issues;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final horizontalPadding = constraints.maxWidth * 0.05;
        final verticalPadding = constraints.maxHeight * 0.05;

        if (selectedView == IssuesViewType.grid) {
          // this keeps the grid from being 1 to 4 columns wide,
          // depending on the screen size
          final horizontalCount = (constraints.maxWidth ~/ 350).clamp(1, 4);

          return GridView.count(
            crossAxisCount: horizontalCount,
            mainAxisSpacing: verticalPadding,
            crossAxisSpacing: horizontalPadding,
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: verticalPadding,
            ),
            children: issues.map(IssueOverviewWidget.gridView).toList(),
          );
        }

        return ListView.separated(
          separatorBuilder: (_, __) => Divider(height: verticalPadding),
          itemCount: issues.length,
          itemBuilder: (context, index) {
            final issue = issues[index];
            return SizedBox(
              // by these values, 2 items will be displayed at all times
              height: constraints.maxHeight * 0.4,
              child: IssueOverviewWidget.listView(issue),
            );
          },
          padding: EdgeInsets.symmetric(
            vertical: verticalPadding,
          ),
        );
      },
    );
  }
}
