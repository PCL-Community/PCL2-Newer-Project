import 'package:flutter/material.dart';

class TransitionPage extends StatefulWidget {
  final bool visible;
  final Widget child;
  final VoidCallback onAfterLeave;
  final Offset offset;

  const TransitionPage({
    super.key,
    this.visible = true,
    required this.child,
    required this.onAfterLeave,
    this.offset = const Offset(-1, 0),
  });

  @override
  State<TransitionPage> createState() => _TransitionPageState();
}

class _TransitionPageState extends State<TransitionPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;
  bool _visible = false;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
    _controller.addStatusListener((status) {
      if (status.isDismissed && !widget.visible) {
        setState(() => _visible = false);
        widget.onAfterLeave();
      }
    });
    _animation = Tween<Offset>(
      begin: widget.offset,
      end: Offset.zero,
    ).animate(_controller);
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
    _controller.removeStatusListener((status) {});
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_visible) {
      return const SizedBox.shrink();
    }
    return SlideTransition(
      position: _animation,
      child: widget.child,
    );
  }
}
