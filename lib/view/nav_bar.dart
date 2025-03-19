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
    final fontColor = widget.index == currentPage
        ? Color.fromARGB(255, 64, 144, 227)
        : Colors.white;
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
          color: widget.index == currentPage ? activeBackColor : backColor,
        ),
        child: TextButton(
          onPressed: () => widget.onPressed(),
          style: ButtonStyle(
            mouseCursor: WidgetStateProperty.all(
              widget.index == currentPage
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
                "  ${widget.buttonText}",
                style: TextStyle(
                  fontSize: 14,
                  color: fontColor,
                ),
              ),
            ],
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

  ///
  /// 构建导航栏的UI，包括导航栏的标题、按钮等的属性。
  /// 不过在里面使用了两个Position属性来区分哪个是背景，哪个是组件（都用了绝对位置
  ///
  ///
  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: widget.toolbarHeight,
      backgroundColor: Color.fromARGB(255, 17, 111, 205),
      title: SizedBox(
        width: double.infinity,
        height: widget.toolbarHeight,
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onPanStart: (_) => windowManager.startDragging(),
                onDoubleTap: () => _toggleMaximize(),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _Navbutton(
                          index: 1,
                          buttonText: "主页",
                          iconData: Icons.home,
                          onPressed: () => setState(() => currentPage = 1),
                        ),
                        _Navbutton(
                          index: 2,
                          buttonText: "下载",
                          iconData: Icons.download,
                          onPressed: () => setState(() => currentPage = 2),
                        ),
                        _Navbutton(
                          index: 3,
                          buttonText: "联机",
                          iconData: Icons.wifi,
                          onPressed: () => setState(() => currentPage = 3),
                        ),
                        _Navbutton(
                          index: 4,
                          buttonText: "设置",
                          iconData: Icons.settings,
                          onPressed: () => setState(() => currentPage = 4),
                        ),
                        _Navbutton(
                          index: 5,
                          buttonText: "更多",
                          iconData: Icons.grid_view,
                          onPressed: () => setState(() => currentPage = 5),
                        ),
                      ],
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
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
