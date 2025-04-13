import 'package:flutter/material.dart';
import 'package:pcl2_newer/view/body.dart';
import 'package:pcl2_newer/view/nav_bar.dart';
import 'package:pcl2_newer/logic/change_body.dart';
// ignore: depend_on_referenced_packages
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();
  WindowOptions windowOptions = WindowOptions(
    size: Size(874, 520),
    center: true,
    titleBarStyle: TitleBarStyle.hidden,
    minimumSize: Size(784, 440),
  );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PCL II Newer Project',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: darkModeListen.value
                ? Color.fromARGB(255, 7, 20, 35)
                : Color.fromARGB(255, 203, 224, 247),
          ),
          useMaterial3: true,
          fontFamily: "PCL-English"),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WindowListener {
  bool isDarkMode = false;
  void updateDark() {
    setState(() {
      isDarkMode = darkModeListen.value;
    });
  }

  @override
  void initState() {
    super.initState();
    darkModeListen.addListener(updateDark);
  }

  @override
  void dispose() {
    darkModeListen.removeListener(updateDark);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: NavBar(),
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        color: isDarkMode
            ? Color.fromARGB(255, 7, 20, 35)
            : Color.fromARGB(255, 203, 224, 247),
        child: Body(),
      ),
    );
  }
}
