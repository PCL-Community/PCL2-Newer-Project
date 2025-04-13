import 'package:flutter/material.dart';
import 'package:pcl2_newer/logic/change_body.dart';
import 'package:pcl2_newer/components/other/transition_page.dart';
import 'package:pcl2_newer/view/about/left.dart';
import 'package:pcl2_newer/view/download/left.dart';
import 'package:pcl2_newer/view/home/left.dart';
import 'package:pcl2_newer/view/online/left.dart';
import 'package:pcl2_newer/view/setting/left.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int currentPage = 1;
  int forwardPage = 1;
  bool isDarkMode = false;
  void updateListen() {
    setState(() {
      currentPage = 0;
      forwardPage = currentPageListen.value;
    });
  }

  void updateDark() {
    setState(() {
      isDarkMode = darkModeListen.value;
    });
  }

  @override
  void initState() {
    super.initState();
    currentPageListen.addListener(updateListen);
    darkModeListen.addListener(updateDark);
  }

  @override
  void dispose() {
    currentPageListen.removeListener(updateListen);
    darkModeListen.removeListener(updateDark);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Stack(
      children: [
        TransitionPage(
          visible: currentPage == 1,
          onAfterLeave: () => setState(() => currentPage = forwardPage),
          offset: Offset(-300, 0),
          opacity: 0,
          child: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            width: 300,
            height: double.infinity,
            color: isDarkMode
                ? Color.fromARGB(255, 41, 41, 43)
                : Color.fromARGB(255, 245, 248, 252),
            child: HomeLeft(),
          ),
        ),
        TransitionPage(
          visible: currentPage == 1,
          onAfterLeave: () => setState(() => currentPage = forwardPage),
          offset: Offset(0, -screenSize.height),
          opacity: 0,
          child: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            margin: EdgeInsets.fromLTRB(300, 0, 0, 0),
            width: screenSize.width - 300,
            height: double.infinity,
            color: Colors.transparent,
          ),
        ),
        TransitionPage(
          visible: currentPage == 2,
          onAfterLeave: () => setState(() => currentPage = forwardPage),
          offset: Offset(-150, 0),
          opacity: 0,
          child: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            width: 150,
            height: double.infinity,
            color: isDarkMode
                ? Color.fromARGB(255, 41, 41, 43)
                : Color.fromARGB(255, 245, 248, 252),
            child: DownloadLeft(),
          ),
        ),
        TransitionPage(
          visible: currentPage == 2,
          onAfterLeave: () => setState(() => currentPage = forwardPage),
          offset: Offset(0, -screenSize.height),
          opacity: 0,
          child: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            margin: EdgeInsets.fromLTRB(150, 0, 0, 0),
            width: screenSize.width - 150,
            height: double.infinity,
            color: Colors.transparent,
          ),
        ),
        TransitionPage(
          visible: currentPage == 3,
          onAfterLeave: () => setState(() => currentPage = forwardPage),
          offset: Offset(-122, 0),
          opacity: 0,
          child: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            width: 122,
            height: double.infinity,
            color: isDarkMode
                ? Color.fromARGB(255, 41, 41, 43)
                : Color.fromARGB(255, 245, 248, 252),
            child: OnlineLeft(),
          ),
        ),
        TransitionPage(
          visible: currentPage == 3,
          onAfterLeave: () => setState(() => currentPage = forwardPage),
          offset: Offset(0, -screenSize.height),
          opacity: 0,
          child: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            margin: EdgeInsets.fromLTRB(122, 0, 0, 0),
            width: screenSize.width - 122,
            height: double.infinity,
            color: Colors.transparent,
          ),
        ),
        TransitionPage(
          visible: currentPage == 4,
          onAfterLeave: () => setState(() => currentPage = forwardPage),
          offset: Offset(-122, 0),
          opacity: 0,
          child: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            width: 122,
            height: double.infinity,
            color: isDarkMode
                ? Color.fromARGB(255, 41, 41, 43)
                : Color.fromARGB(255, 245, 248, 252),
            child: SettingLeft(),
          ),
        ),
        TransitionPage(
          visible: currentPage == 4,
          onAfterLeave: () => setState(() => currentPage = forwardPage),
          offset: Offset(0, -screenSize.height),
          opacity: 0,
          child: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            margin: EdgeInsets.fromLTRB(122, 0, 0, 0),
            width: screenSize.width - 122,
            height: double.infinity,
            color: Colors.transparent,
          ),
        ),
        TransitionPage(
          visible: currentPage == 5,
          onAfterLeave: () => setState(() => currentPage = forwardPage),
          offset: Offset(-150, 0),
          opacity: 0,
          child: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            width: 150,
            height: double.infinity,
            color: isDarkMode
                ? Color.fromARGB(255, 41, 41, 43)
                : Color.fromARGB(255, 245, 248, 252),
            child: AboutLeft(),
          ),
        ),
        TransitionPage(
          visible: currentPage == 5,
          onAfterLeave: () => setState(() => currentPage = forwardPage),
          offset: Offset(0, -screenSize.height),
          opacity: 0,
          child: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            margin: EdgeInsets.fromLTRB(150, 0, 0, 0),
            width: screenSize.width - 150,
            height: double.infinity,
            color: Colors.transparent,
          ),
        ),
      ],
    );
  }
}
