part of 'sticky_header.dart';

class StickyHeaderData {
  final Size headerSize;
  final Size childSize;
  final double progress;
  final double childProgress;
  final bool isOverlaps;

  StickyHeaderData({
    this.headerSize = Size.zero,
    this.childSize = Size.zero,
    this.progress = 0,
    this.childProgress = 0,
  }) : isOverlaps = progress > 0 || childProgress > 0;
}
