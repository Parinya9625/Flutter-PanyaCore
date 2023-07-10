import 'dart:math';
import 'dart:ui';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/rendering.dart';

part 'render_sticky_header.dart';
part 'sticky_header_data.dart';

/// The `data` object provides useful data for handle [StickyHeader]
typedef StickyHeaderCallback = void Function(StickyHeaderData data);

/// Widget that will pinned header on top when scroll and will
/// hide header when scroll to last position of child
class StickyHeader extends MultiChildRenderObjectWidget {
  /// Widget that will show before [child]
  final Widget header;

  /// Widget that will show after [header]
  final Widget child;

  /// Control how [header] will be sticky in scroll widget
  final bool sticky;

  /// Control how [child] will be render
  ///
  /// if `true` : [child] will be render underneath [header] <br>
  /// if `false` : [child] will be render next to [header]
  final bool overlapHeader;

  /// Function that will call when widget have scroll update or repaint
  final StickyHeaderCallback? callback;

  /// Create Widget that will pinned header on top when scroll and will
  /// hide header when scroll to last position of child
  ///
  /// ```dart
  /// ListView(
  ///   children: [
  ///     StickyHeader(
  ///       header: Container(
  ///         height: kToolbarHeight,
  ///         color: Colors.red,
  ///       ),
  ///       child: const Column(
  ///         children: [
  ///           // Other widget
  ///         ],
  ///       ),
  ///     ),
  ///   ],
  /// );
  /// ```
  StickyHeader({
    super.key,
    required this.header,
    required this.child,
    this.sticky = true,
    this.overlapHeader = false,
    this.callback,
  }) : super(
          children: [child, header],
        );

  @override
  RenderObject createRenderObject(BuildContext context) {
    final scrollPosition = Scrollable.maybeOf(context)?.position;
    return RenderStickyHeader(
      scrollPosition: scrollPosition,
      callback: callback,
      sticky: sticky,
      overlapHeader: overlapHeader,
    );
  }

  @override
  void updateRenderObject(
    BuildContext context,
    RenderStickyHeader renderObject,
  ) {
    final scrollPosition = Scrollable.maybeOf(context)?.position;
    renderObject
      ..scrollPosition = scrollPosition
      ..callback = callback
      ..sticky = sticky
      ..overlapHeader = overlapHeader;
  }
}
