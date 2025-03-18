import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:window_manager/window_manager.dart';
import 'package:pcl2_newer/logic/change_body.dart';

///
/// 导航栏按钮，该按钮不属于可公开的样式，仅在本文件中使用。
///
class _Navbutton extends StatefulWidget {
  final String buttonText;
  final IconData iconData;
  final int index;
  final Function onPressed;

  const _Navbutton(
      {required this.index,
      required this.buttonText,
      required this.iconData,
      required this.onPressed});
  @override
  State<_Navbutton> createState() => _NavbuttonState();
}

///
/// 导航栏按钮的状态，用于管理导航栏按钮的状态，包括鼠标悬停、点击等的状态。
///
class _NavbuttonState extends State<_Navbutton> {
  bool isHovered = false;

  ///
  /// 构建导航栏按钮的UI，包括鼠标悬停、点击等的状态。
  ///
  @override
  Widget build(BuildContext context) {
    ///
    /// 在鼠标悬停时，设置isHovered的属性。
    ///
    final backColor = isHovered
        ? Color.fromARGB(255, 64, 144, 227)
        : Color.fromARGB(255, 17, 111, 205);
    final activeBackColor = Colors.white;
    final fontColor =
        widget.index == page ? Color.fromARGB(255, 64, 144, 227) : Colors.white;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onHover: (event) => setState(() => isHovered = true),
      onExit: (event) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        // padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
        margin: EdgeInsets.fromLTRB(8, 0, 8, 0),
        decoration: BoxDecoration(
          color: widget.index == page ? activeBackColor : backColor,
          borderRadius: BorderRadius.circular(30),
        ),
        child: ElevatedButton.icon(
          onPressed: widget.onPressed as void Function()?,
          label: RichText(
            text: TextSpan(
              text: widget.buttonText,
              style: TextStyle(color: fontColor),
            ),
          ),
          icon: Icon(widget.iconData),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
            minimumSize: const Size(0, 40),
            iconColor: fontColor,
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
                      _Navbutton(
                        index: 1,
                        buttonText: "主页",
                        iconData: Icons.home,
                        onPressed: () => setState(() => page = 1),
                      ),
                      _Navbutton(
                        index: 2,
                        buttonText: "下载",
                        iconData: Icons.download,
                        onPressed: () => setState(() => page = 2),
                      ),
                      _Navbutton(
                        index: 3,
                        buttonText: "联机",
                        iconData: Icons.wifi,
                        onPressed: () => setState(() => page = 3),
                      ),
                      _Navbutton(
                        index: 4,
                        buttonText: "设置",
                        iconData: Icons.settings,
                        onPressed: () => setState(() => page = 4),
                      ),
                      _Navbutton(
                        index: 5,
                        buttonText: "更多",
                        iconData: Icons.grid_view,
                        onPressed: () => setState(() => page = 5),
                      ),
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
