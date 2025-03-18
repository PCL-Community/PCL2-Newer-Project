import 'package:flutter/material.dart';
import 'package:pcl2_newer/view/nav_bar.dart';
// ignore: depend_on_referenced_packages
import 'package:window_manager/window_manager.dart';

///
/// 主函数（必须异步调用，才能正常设置Window窗口设置）
///
void main() async {
  ///
  /// Window窗口设置【不仅限于Windows操作系统】
  ///
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  ///
  /// 设置Window的大小、位置、标题栏、最小大小等属性
  ///
  WindowOptions windowOptions = WindowOptions(
    size: Size(874, 520),
    center: true,
    titleBarStyle: TitleBarStyle.hidden,
    minimumSize: Size(784, 440),
  );

  ///
  /// 设置Window的显示、焦点的函数，在Window窗口准备好后，显示Window窗口，并且将焦点设置到Window窗口上。
  ///
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });

  ///
  /// 运行Flutter应用程序
  ///
  runApp(const MyApp());
}

///
/// 主应用程序
///
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  ///
  /// 构建应用程序的UI
  ///
  @override
  Widget build(BuildContext context) {
    ///
    /// 创建MaterialApp应用程序，设置应用程序的标题、主题、主页等属性
    ///
    return MaterialApp(
      ///
      /// 应用程序的标题
      ///
      title: 'PCL II Newer Project',

      ///
      /// 应用程序的主题，使用Material3主题，设置主色为PCL2默认颜色
      ///
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 203, 224, 247)),
        useMaterial3: true,
      ),

      ///
      /// 应用程序的主页
      ///
      home: const MyHomePage(),
    );
  }
}

///
/// 主页，具体来说应该是整体的框架，包括导航栏、主体内容、悬浮按钮等
///
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

///
/// 主页的状态，用于管理主页的状态，可以切换主页的内容，使用了WindowListener来监听Window窗口的事件
///
class _MyHomePageState extends State<MyHomePage> with WindowListener {
  int _counter = 0;
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  ///
  /// 构建主页的UI，包括导航栏、主体内容、悬浮按钮等
  ///
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      ///
      /// 应用程序的导航栏，使用了自定义的NavBar组件
      ///
      appBar: NavBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
