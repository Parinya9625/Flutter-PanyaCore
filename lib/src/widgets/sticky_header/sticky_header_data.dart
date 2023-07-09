part of 'sticky_header.dart';

/// [StickyHeader] latest data that will get from [StickyHeader.callback]
class StickyHeaderData {
  /// [StickyHeader.header] size
  final Size headerSize;

  /// [StickyHeader.child] size
  final Size childSize;

  /// Indicate the visibility progress of [StickyHeader] widget
  /// return 0 when widget position at top of the scrolling widget and
  /// will increase to 1 when scroll to the end of widget and widget no
  /// longer visible
  final double progress;

  /// Indicate the visibility progress of [StickyHeader.child] widget
  /// return 0 when [StickyHeader.child] position at top of the scrolling
  /// widget and will increase to 1 when [StickyHeader.child] no longer visible
  /// (but [StickyHeader.header] still shown)
  final double childProgress;

  /// Indicate that [StickyHeader.child] is underneath [StickyHeader.header]
  /// and widget start scrolling
  final bool isOverlaps;

  /// [StickyHeader] latest data that will get from [StickyHeader.callback]
  StickyHeaderData({
    this.headerSize = Size.zero,
    this.childSize = Size.zero,
    this.progress = 0,
    this.childProgress = 0,
  }) : isOverlaps = progress > 0 || childProgress > 0;
}
