import 'package:flutter/material.dart';

class MyNormalButton extends StatefulWidget {
  final VoidCallback onClick;
  final double width;
  final double height;
  final Widget child;
  final int duration;
  const MyNormalButton({
    super.key,
    required this.onClick,
    required this.width,
    required this.height,
    required this.child,
    this.duration = 100,
  });
  @override
  State<MyNormalButton> createState() => _MyNormalButtonState();
}
class _MyNormalButtonState extends State<MyNormalButton> {
  bool _isHovered = false;
  bool _isPressed = false;
  @override
  Widget build(BuildContext c) {
    return MouseRegion(
      onHover: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) => setState(() => _isPressed = false),
        onTapCancel: () => setState(() => _isPressed = false),
        onTap: () => widget.onClick(),
        child: AnimatedContainer(
          decoration: BoxDecoration(
            border: Border.all(color: Color.fromARGB(255, 51, 62, 72)),
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: _isHovered ? Color.fromARGB(200, 180, 255, 255) : Color.fromARGB(180, 255, 255, 180),
          ),
          duration: Duration(milliseconds: widget.duration),
          width: widget.width,
          height: widget.height,
          transform: Matrix4.identity()
            ..translate(widget.width / 2, widget.height / 2)
            ..scale(_isPressed ? 0.98 : 1.0)
            ..translate(-widget.width / 2, -widget.height / 2),
          child: Center(
            child: widget.child,
          ),
        ),
      ),
    );
  }
}