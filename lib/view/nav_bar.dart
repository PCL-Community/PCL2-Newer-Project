import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:window_manager/window_manager.dart';
import 'package:pcl2_newer/logic/change_body.dart';

class Navbutton extends StatefulWidget {
  final String buttonText;
  final IconData iconData;
  const Navbutton(
      {super.key, required this.buttonText, required this.iconData});
  @override
  State<Navbutton> createState() => _NavbuttonState();
}

class _NavbuttonState extends State<Navbutton> {
  bool isHovered = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: (event) => setState(() => isHovered = true),
      onExit: (event) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
        margin: EdgeInsets.fromLTRB(8, 4, 8, 4),
        decoration: BoxDecoration(
          color: isHovered
              ? Color.fromARGB(255, 64, 144, 227)
              : Color.fromARGB(255, 17, 111, 205),
          borderRadius: BorderRadius.circular(30),
        ),
        child: ElevatedButton.icon(
          onPressed: () {},
          label: RichText(
            text: TextSpan(
              text: widget.buttonText,
              style: TextStyle(color: Colors.white),
            ),
          ),
          icon: Icon(widget.iconData),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            padding: EdgeInsets.zero,
            minimumSize: const Size(0, 40),
            iconColor: Colors.white,
          ),
        ),
      ),
    );
  }
}

class NavBar extends StatefulWidget implements PreferredSizeWidget {
  final double toolbarHeight;
  const NavBar({super.key, this.toolbarHeight = 48});
  @override
  State<NavBar> createState() => _NavBarState();
  @override
  Size get preferredSize => Size.fromHeight(toolbarHeight); // 设置高度
}

class _NavBarState extends State<NavBar> with WindowListener {
  Future<void> _toggleMaximize() async {
    final isMaximized = await windowManager.isMaximized();
    if (isMaximized) {
      await windowManager.unmaximize();
    } else {
      await windowManager.maximize();
    }
  }

  MouseRegion titleButton(String buttonText, IconData iconData) {
    return MouseRegion(
      child: Padding(
        padding: EdgeInsets.fromLTRB(6, 0, 6, 0),
        child: ElevatedButton.icon(
          onPressed: () {},
          label: RichText(
            text: TextSpan(
              text: buttonText,
              style: TextStyle(color: Colors.white),
            ),
          ),
          icon: Icon(iconData),
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.resolveWith((states) {
              return states.contains(WidgetState.hovered)
                  ? Color.fromARGB(255, 64, 144, 227)
                  : Color.fromARGB(255, 17, 111, 205);
            }),
            iconColor: WidgetStateProperty.all(Colors.white),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onPanStart: (_) => windowManager.startDragging(),
        onDoubleTap: () => _toggleMaximize(),
        child: SizedBox(
          width: double.infinity,
          height: widget.toolbarHeight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.centerLeft,
                width: 100,
                height: widget.toolbarHeight,
                child: Text(
                  "PCL II",
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Navbutton(buttonText: "主页", iconData: Icons.home),
                      Navbutton(buttonText: "下载", iconData: Icons.download),
                      Navbutton(buttonText: "联机", iconData: Icons.wifi),
                      Navbutton(buttonText: "设置", iconData: Icons.settings),
                      Navbutton(buttonText: "更多", iconData: Icons.grid_view),
                    ],
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                width: 100,
                height: widget.toolbarHeight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {
                        windowManager.minimize();
                      },
                      icon: Icon(
                        Icons.horizontal_rule,
                        color: Colors.white,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        windowManager.close();
                      },
                      icon: Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      toolbarHeight: widget.toolbarHeight,
      backgroundColor: Color.fromARGB(255, 17, 111, 205),
    );
  }
}
