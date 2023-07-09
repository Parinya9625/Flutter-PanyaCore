import 'dart:math';
import 'dart:ui';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/rendering.dart';

part 'render_sticky_header.dart';
part 'sticky_header_data.dart';

typedef StickyHeaderCallback = void Function(StickyHeaderData data);

class StickyHeader extends MultiChildRenderObjectWidget {
  final Widget header;
  final Widget child;
  final bool sticky;
  final StickyHeaderCallback? callback;

  StickyHeader({
    super.key,
    required this.header,
    required this.child,
    this.sticky = true,
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
      ..sticky = sticky;
  }
}
