import 'package:flutter/widgets.dart';

int _kDefaultSemanticIndexCallback(_, int localIndex) => localIndex ~/ 2;

class SliverSeparatedBuilderDelegate extends SliverChildBuilderDelegate {
  SliverSeparatedBuilderDelegate(
    NullableIndexedWidgetBuilder builder, {
    required WidgetBuilder separator,
    required int childCount,
    super.findChildIndexCallback,
    super.addAutomaticKeepAlives,
    super.addRepaintBoundaries,
    super.addSemanticIndexes,
    super.semanticIndexCallback = _kDefaultSemanticIndexCallback,
    super.semanticIndexOffset,
  }) : super(
          (context, index) =>
              index.isOdd ? separator(context) : builder(context, index ~/ 2),
          childCount: childCount * 2 - 1,
        );
}
