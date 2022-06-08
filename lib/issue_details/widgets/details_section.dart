import 'package:comic_book_explorer/utils/maybe_at.dart';
import 'package:comic_vine_api/comic_vine_api.dart';
import 'package:flutter/material.dart';

/// {@template issue_details_page}
/// A widget that displays an issue's properties details.
/// {@endtemplate}
class IssueDetailsSectionWidget extends StatelessWidget {
  /// {@macro issue_details_page}
  const IssueDetailsSectionWidget({
    required this.items,
    required this.title,
    super.key,
  });

  /// The items to display in the section.
  final Iterable<ComicVineImageResponse> items;

  /// The title of the section.
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // title
          Text(
            title,
            style: Theme.of(context).textTheme.headline6,
          ),
          const Divider(height: 30),
          // items
          Builder(
            builder: (context) {
              // map the items to a list of widgets
              final itemsWidgets = items.map(
                (item) => _IssueDetailsSectionItemWidget(
                  imageUrl: item.image?.tinyUrl ?? item.image?.iconUrl,
                  name: item.name,
                ),
              );

              final itemsRows = <TableRow>[];

              // make itemsRows have 2 items per row. source is itemsWidgets
              for (var i = 0; i < itemsWidgets.length; i += 2) {
                itemsRows.add(
                  TableRow(
                    children: [
                      itemsWidgets.maybeAt(i) ?? const SizedBox.shrink(),
                      itemsWidgets.maybeAt(i + 1) ?? const SizedBox.shrink(),
                    ],
                  ),
                );
              }

              return Table(children: itemsRows);
            },
          ),
        ],
      ),
    );
  }
}

class _IssueDetailsSectionItemWidget extends StatelessWidget {
  const _IssueDetailsSectionItemWidget({
    required this.imageUrl,
    required this.name,
  });

  final String? imageUrl;
  final String? name;

  @override
  Widget build(BuildContext context) {
    final _imageUrl = imageUrl;
    final _name = name;

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          if (_imageUrl != null) Image.network(_imageUrl),
          const SizedBox(width: 8),
          if (_name != null)
            Text(
              _name,
              style: Theme.of(context).textTheme.bodyText1,
            ),
        ],
      ),
    );
  }
}
