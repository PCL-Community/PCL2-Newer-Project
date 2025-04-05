import 'package:flutter/material.dart';
import 'package:pcl2_newer/logic/change_body.dart';

class MyCheckButton extends StatefulWidget {
  final bool isChecked;
  final IconData iconData;
  final String text;
  final int index;
  final Function onPressed;
  const MyCheckButton({
    super.key,
    this.isChecked = false,
    required this.iconData,
    required this.text,
    required this.index,
    required this.onPressed,
  });

  @override
  State<MyCheckButton> createState() => _MyCheckButtonState();
}

class _MyCheckButtonState extends State<MyCheckButton> {
  bool isHovered = false;
  @override
  Widget build(BuildContext context) {
    final backColor = isHovered
        ? darkModeListen.value
            ? Color.fromARGB(255, 32, 32, 32)
            : Color.fromARGB(255, 222, 237, 252)
        : Colors.transparent;
    final activeBackColor = Color.fromARGB(255, 18, 122, 225);
    final fontColor = widget.isChecked
        ? Colors.white
        : darkModeListen.value
            ? Colors.white
            : Color.fromARGB(255, 20, 123, 225);
    return MouseRegion(
        onHover: (event) => setState(() => isHovered = true),
        onExit: (event) => setState(() => isHovered = false),
        child: AnimatedContainer(
          height: 28,
          width: 80,
          duration: Duration(milliseconds: 200),
          margin: EdgeInsets.fromLTRB(4, 0, 4, 0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: widget.isChecked ? activeBackColor : backColor,
          ),
          child: TextButton(
            onPressed: () => widget.onPressed(),
            style: ButtonStyle(
              mouseCursor: WidgetStateProperty.all(
                widget.isChecked
                    ? SystemMouseCursors.basic
                    : SystemMouseCursors.click,
              ),
              splashFactory: NoSplash.splashFactory,
              overlayColor: WidgetStateProperty.all(Colors.transparent),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  widget.iconData,
                  color: fontColor,
                  size: 16,
                ),
                Text(
                  "  ${widget.text}",
                  style: TextStyle(
                    fontSize: 14,
                    color: fontColor,
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
