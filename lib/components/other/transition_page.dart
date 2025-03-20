import 'package:flutter/material.dart';

class TransitionPage extends StatefulWidget {
  final bool visible;
  final Widget child;
  final VoidCallback onAfterLeave;
  final Offset offset;
  final double opacity;
  final double scale;

  const TransitionPage({
    super.key,
    this.visible = true,
    required this.child,
    required this.onAfterLeave,
    this.offset = const Offset(0, 0),
    this.opacity = 1,
    this.scale = 1,
  });

  @override
  State<TransitionPage> createState() => _TransitionPageState();
}

class _TransitionPageState extends State<TransitionPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slide;
  late Animation<double> _opacity;
  late Animation<double> _scale;
  bool _visible = false;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _controller.addStatusListener((status) {
      if (status.isDismissed && !widget.visible) {
        setState(() => _visible = false);
        widget.onAfterLeave();
      }
    });
    final curved = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut, // 统一缓动曲线
    );
    _slide = Tween<Offset>(
      begin: widget.offset,
      end: Offset.zero,
    ).animate(curved);
    _opacity = Tween<double>(
      begin: widget.opacity,
      end: 1,
    ).animate(curved);
    _scale = Tween<double>(
      begin: widget.scale,
      end: 1,
    ).animate(curved);
    _visible = widget.visible;
    if (_visible) {
      _controller.forward();
    }
  }

  @override
  void didUpdateWidget(TransitionPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.visible != oldWidget.visible) {
      if (widget.visible) {
        setState(() => _visible = true);
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_visible) {
      return const SizedBox.shrink();
    }
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform(
          transform: Matrix4.identity()
            ..translate(
              _slide.value.dx,
              _slide.value.dy,
              0,
            )
            ..scale(_scale.value),
          child: Opacity(
            opacity: _opacity.value,
            child: child,
          ),
        );
      },
      child: widget.child,
    );
  }
}
