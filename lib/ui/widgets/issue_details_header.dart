import 'package:flutter/material.dart';

class IssueDetailsHeader extends SliverPersistentHeaderDelegate {
  IssueDetailsHeader({
    required this.buildIcon,
    required this.title,
    required this.title2,
  });

  final Widget Function(double size) buildIcon;
  final String title;

  final String title2;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          border: Border.all(color: Theme.of(context).dividerColor),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment(0, 1 - (shrinkOffset / maxExtent)),
              child: Text(title),
            ),
            Align(
              alignment: Alignment(-(shrinkOffset / maxExtent), 0),
              child: buildIcon(minExtent +
                  (1 - (shrinkOffset / maxExtent)) *
                      (maxExtent - minExtent - 64)),
            ),
            Align(
              alignment: Alignment(1, 1 - (shrinkOffset / maxExtent)),
              child: Text(title2),
            ),
          ],
        ),
      ),
    );
  }

  @override
  double get maxExtent => 260;

  @override
  double get minExtent => 64;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}
