import 'package:flutter/material.dart';
import 'package:pcl2_newer/logic/change_body.dart';
import 'package:pcl2_newer/components/other/transition_page.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int currentPage = 1;
  int forwardPage = 1;
  @override
  void initState() {
    super.initState();
    myListener.addListener(
      () => setState(
        () {
          currentPage = 0;
          forwardPage = myListener.currentPage;
        },
      ),
    );
  }

  void changePage(int index) {
    setState(() {
      currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Stack(
      children: [
        TransitionPage(
          visible: currentPage == 1,
          onAfterLeave: () {
            changePage(forwardPage);
          },
          offset: Offset(-300, 0),
          opacity: 0,
          child: Container(
            width: 300,
            height: double.infinity,
            color: Color.fromARGB(255, 245, 248, 252),
          ),
        ),
        TransitionPage(
          visible: currentPage == 1,
          onAfterLeave: () {
            changePage(forwardPage);
          },
          offset: Offset(0, -screenSize.height),
          opacity: 0,
          child: Container(
            margin: EdgeInsets.fromLTRB(300, 0, 0, 0),
            width: screenSize.width - 300,
            height: double.infinity,
          ),
        ),
        TransitionPage(
          visible: currentPage == 2,
          onAfterLeave: () {
            changePage(forwardPage);
          },
          offset: Offset(-150, 0),
          opacity: 0,
          child: Container(
            width: 150,
            height: double.infinity,
            color: Color.fromARGB(255, 245, 248, 252),
          ),
        ),
        TransitionPage(
          visible: currentPage == 2,
          onAfterLeave: () {
            changePage(forwardPage);
          },
          offset: Offset(0, -screenSize.height),
          opacity: 0,
          child: Container(
            margin: EdgeInsets.fromLTRB(150, 0, 0, 0),
            width: screenSize.width - 150,
            height: double.infinity,
          ),
        ),
        TransitionPage(
          visible: currentPage == 3,
          onAfterLeave: () {
            changePage(forwardPage);
          },
          offset: Offset(-122, 0),
          opacity: 0,
          child: Container(
            width: 122,
            height: double.infinity,
            color: Color.fromARGB(255, 245, 248, 252),
          ),
        ),
        TransitionPage(
          visible: currentPage == 3,
          onAfterLeave: () {
            changePage(forwardPage);
          },
          offset: Offset(0, -screenSize.height),
          opacity: 0,
          child: Container(
            margin: EdgeInsets.fromLTRB(122, 0, 0, 0),
            width: screenSize.width - 122,
            height: double.infinity,
          ),
        ),
        TransitionPage(
          visible: currentPage == 4,
          onAfterLeave: () {
            changePage(forwardPage);
          },
          offset: Offset(-122, 0),
          opacity: 0,
          child: Container(
            width: 122,
            height: double.infinity,
            color: Color.fromARGB(255, 245, 248, 252),
          ),
        ),
        TransitionPage(
          visible: currentPage == 4,
          onAfterLeave: () {
            changePage(forwardPage);
          },
          offset: Offset(0, -screenSize.height),
          opacity: 0,
          child: Container(
            margin: EdgeInsets.fromLTRB(122, 0, 0, 0),
            width: screenSize.width - 122,
            height: double.infinity,
          ),
        ),
        TransitionPage(
          visible: currentPage == 5,
          onAfterLeave: () {
            changePage(forwardPage);
          },
          offset: Offset(-150, 0),
          opacity: 0,
          child: Container(
            width: 150,
            height: double.infinity,
            color: Color.fromARGB(255, 245, 248, 252),
          ),
        ),
        TransitionPage(
          visible: currentPage == 5,
          onAfterLeave: () {
            changePage(forwardPage);
          },
          offset: Offset(0, -screenSize.height),
          opacity: 0,
          child: Container(
            margin: EdgeInsets.fromLTRB(150, 0, 0, 0),
            width: screenSize.width - 150,
            height: double.infinity,
          ),
        ),
      ],
    );
  }
}
