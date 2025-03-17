import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:window_manager/window_manager.dart';

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
                      ElevatedButton.icon(
                        onPressed: () {},
                        label: Text("主页"),
                        icon: Icon(Icons.home),
                        style: ButtonStyle(),
                      ),
                      ElevatedButton.icon(
                        onPressed: () {},
                        label: Text("下载"),
                        icon: Icon(Icons.download),
                      ),
                      ElevatedButton.icon(
                        onPressed: () {},
                        label: Text("联机"),
                        icon: Icon(Icons.wifi),
                      ),
                      ElevatedButton.icon(
                        onPressed: () {},
                        label: Text("设置"),
                        icon: Icon(Icons.settings),
                      ),
                      ElevatedButton.icon(
                        onPressed: () {},
                        label: Text("更多"),
                        icon: Icon(Icons.grid_view),
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
                      onPressed: () {},
                      icon: Icon(
                        Icons.horizontal_rule,
                        color: Colors.white,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
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
          // child: Row(
          //   children: [
          //     Text(
          //       "PCL II",
          //       textAlign: TextAlign.left,
          //       style: TextStyle(
          //         color: Colors.white,
          //         fontSize: 24,
          //       ),
          //     ),
          //     Container(
          //       margin: EdgeInsetsGeometry.infinity,
          //       alignment: Alignment.center,
          //       width: 300,
          //       child: Row(
          //         children: [],
          //       ),
          //     )
          //   ],
          // ),
        ),
      ),
      toolbarHeight: widget.toolbarHeight,
      backgroundColor: Color.fromARGB(255, 17, 111, 205),
    );
  }
}
