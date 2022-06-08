import 'package:comic_vine_api/comic_vine_api.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// {@template issue_overview_widget}
/// Whether the issue will be displayed in a list or a grid.
/// {@endtemplate}
enum IssuesViewType {
  /// The issue will be displayed in a list.
  list,

  /// The issue will be displayed in a grid.
  grid,
}

/// {@template issue_overview_widget}
/// The
/// Can display the issues in a list or a grid.
/// {@endtemplate}
class IssueOverviewWidget extends StatelessWidget {
  /// {@macro issue_overview_widget}
  const IssueOverviewWidget.listView(
    this.issue, {
    super.key,
  }) : _viewType = IssuesViewType.list;

  /// {@macro issue_overview_widget}
  const IssueOverviewWidget.gridView(
    this.issue, {
    super.key,
  }) : _viewType = IssuesViewType.grid;

  /// The issue to display.
  final ComicVineIssue issue;

  /// The issue to display.
  final IssuesViewType _viewType;

  @override
  Widget build(BuildContext context) {
    final name = '${issue.name ?? ''} #${issue.issueNumber}';
    final date = issue.dateAdded;
    final imageUrl = issue.image?.originalUrl;

    if (_viewType == IssuesViewType.list) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          if (imageUrl != null)
            Flexible(
              child: Image.network(imageUrl),
            ),
          Flexible(
            child: Column(
              children: [
                Text(
                  name,
                  style: Theme.of(context).textTheme.titleSmall,
                  textAlign: TextAlign.center,
                ),
                if (date != null)
                  Text(
                    DateFormat('MMMM dd, y').format(date),
                    textAlign: TextAlign.center,
                  ),
              ],
            ),
          )
        ],
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (imageUrl != null)
          Flexible(
            child: Image.network(imageUrl),
          ),
        Text(
          name,
          style: Theme.of(context).textTheme.titleSmall,
          textAlign: TextAlign.center,
        ),
        if (date != null)
          Text(
            DateFormat('MMMM dd, y').format(date),
            textAlign: TextAlign.center,
          ),
      ],
    );
  }
}
