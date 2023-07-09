part of 'sticky_header.dart';

typedef RenderStickyHeaderCallback = void Function(StickyHeaderData data);

class RenderStickyHeader extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, MultiChildLayoutParentData>,
        RenderBoxContainerDefaultsMixin<RenderBox, MultiChildLayoutParentData> {
  // ---------------

  ScrollPosition? _scrollPosition;
  RenderStickyHeaderCallback? _callback;

  RenderStickyHeader({
    ScrollPosition? scrollPosition,
    RenderBox? header,
    RenderBox? child,
    RenderStickyHeaderCallback? callback,
  })  : _scrollPosition = scrollPosition,
        _callback = callback {
    if (child != null) add(child);
    if (header != null) add(header);
  }

  // ---------------

  RenderBox get _headerBox => lastChild!;
  RenderBox get _childBox => firstChild!;
  MultiChildLayoutParentData get _headerParentData =>
      _headerBox.parentData as MultiChildLayoutParentData;
  MultiChildLayoutParentData get _childParentData =>
      _childBox.parentData as MultiChildLayoutParentData;
  double get devicePixelRatio =>
      PlatformDispatcher.instance.views.first.devicePixelRatio;

  set scrollPosition(ScrollPosition? value) {
    if (_scrollPosition != value) return;

    final oldScrollPosition = _scrollPosition;
    _scrollPosition = value;
    markNeedsLayout();

    if (attached) {
      oldScrollPosition?.removeListener(markNeedsLayout);
      _scrollPosition?.addListener(markNeedsLayout);
    }
  }

  set callback(RenderStickyHeaderCallback? value) {
    if (_callback != value) return;

    _callback = value;
    markNeedsLayout();
  }

  // ---------------

  double roundToNearestPixel(double offset) {
    return (offset * devicePixelRatio).roundToDouble() / devicePixelRatio;
  }

  double getStuckOffset() {
    final scrollBox =
        _scrollPosition?.context.notificationContext?.findRenderObject();

    if (scrollBox?.attached ?? false) {
      try {
        return localToGlobal(Offset.zero, ancestor: scrollBox).dy;
      } catch (_) {}
    }
    return 0;
  }

  // ---------------

  @override
  bool get isRepaintBoundary => true;

  @override
  void attach(PipelineOwner owner) {
    super.attach(owner);
    _scrollPosition?.addListener(markNeedsLayout);
  }

  @override
  void detach() {
    _scrollPosition?.removeListener(markNeedsLayout);
    super.detach();
  }

  @override
  void setupParentData(covariant RenderObject child) {
    super.setupParentData(child);
    if (child.parentData is! MultiChildLayoutParentData) {
      child.parentData = MultiChildLayoutParentData();
    }
  }

  @override
  void performLayout() {
    // Calculate header and child size
    final childConstraints = constraints.loosen();
    _headerBox.layout(childConstraints, parentUsesSize: true);
    _childBox.layout(childConstraints, parentUsesSize: true);

    final headerHeight = roundToNearestPixel(_headerBox.size.height);
    final childHeight = roundToNearestPixel(_childBox.size.height);

    // Calculate and set overall widget size
    final width = constraints.constrainWidth(
      max(constraints.minWidth, childHeight),
    );
    final height = constraints.constrainHeight(
      max(constraints.minHeight, headerHeight + childHeight),
    );
    size = Size(width, height);

    // Set header position
    final stuckOffset = roundToNearestPixel(getStuckOffset());
    final maxOffset = height - headerHeight;
    _headerParentData.offset = Offset(0, max(0, min(-stuckOffset, maxOffset)));

    // Set child position
    _childParentData.offset = Offset(0, headerHeight);

    // Send some data back to widget
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _callback?.call(
        StickyHeaderData(
          headerSize: _headerBox.size,
          childSize: _childBox.size,
          progress:
              (min(min(0, stuckOffset), height).abs() / height).clamp(0, 1),
          childProgress:
              (min(min(0, stuckOffset), childHeight).abs() / childHeight)
                  .clamp(0, 1),
        ),
      );
    });
  }

  // ---------------

  @override
  double computeMinIntrinsicWidth(double height) {
    return _childBox.getMaxIntrinsicWidth(height);
  }

  @override
  double computeMaxIntrinsicWidth(double height) {
    return _childBox.getMinIntrinsicWidth(height);
  }

  @override
  double computeMinIntrinsicHeight(double width) {
    return _childBox.getMaxIntrinsicHeight(width);
  }

  @override
  double computeMaxIntrinsicHeight(double width) {
    return _childBox.getMaxIntrinsicHeight(width);
  }

  @override
  double? computeDistanceToActualBaseline(TextBaseline baseline) {
    return defaultComputeDistanceToHighestActualBaseline(baseline);
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    return defaultHitTestChildren(result, position: position);
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    defaultPaint(context, offset);
  }

  // ---------------
}
