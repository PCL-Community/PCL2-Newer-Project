import 'package:flutter/material.dart';
import 'package:pcl2_newer/components/button/my_check_button.dart';
// ignore: unused_import
import 'package:pcl2_newer/components/button/my_normal_button.dart';
import 'package:pcl2_newer/components/other/transition_page.dart';
import 'package:pcl2_newer/logic/change_body.dart';
import 'package:pcl2_newer/view/home/content/microsoft.dart';
import 'package:pcl2_newer/view/home/content/offline.dart';
import 'package:pcl2_newer/view/home/content/thirdparty.dart';

class HomeLeft extends StatefulWidget {
  const HomeLeft({super.key});

  @override
  State<HomeLeft> createState() => _HomeLeftState();
}

class _HomeLeftState extends State<HomeLeft> {
  int currentAccount = 1;
  int forwardAccount = 1;
  void updateListen() {
    setState(() {
      currentAccount = 0;
      forwardAccount = currentAccountListen.value;
    });
  }

  @override
  void initState() {
    super.initState();
    currentAccountListen.addListener(updateListen);
  }

  @override
  void dispose() {
    currentAccountListen.removeListener(updateListen);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 50,
          width: 300,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyCheckButton(
                  iconData: Icons.shield_moon,
                  text: "正版",
                  index: 1,
                  onPressed: () => currentAccountListen.value = 1,
                  isChecked: currentAccountListen.value == 1,
                ),
                MyCheckButton(
                  iconData: Icons.medication_outlined,
                  text: "离线",
                  index: 2,
                  onPressed: () => currentAccountListen.value = 2,
                  isChecked: currentAccountListen.value == 2,
                ),
                MyCheckButton(
                  iconData: Icons.account_box_rounded,
                  text: "外置",
                  index: 3,
                  onPressed: () => currentAccountListen.value = 3,
                  isChecked: currentAccountListen.value == 3,
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Column(
            children: [
              SizedBox(
                height: 150,
                width: 300,
                child: Stack(
                  children: [
                    TransitionPage(
                      visible: currentAccount == 1,
                      onAfterLeave: () =>
                          setState(() => currentAccount = forwardAccount),
                      opacity: 0,
                      child: Microsoft(),
                    ),
                    TransitionPage(
                      visible: currentAccount == 2,
                      onAfterLeave: () =>
                          setState(() => currentAccount = forwardAccount),
                      opacity: 0,
                      child: Offline(),
                    ),
                    TransitionPage(
                      visible: currentAccount == 3,
                      onAfterLeave: () =>
                          setState(() => currentAccount = forwardAccount),
                      opacity: 0,
                      child: Thirdparty(),
                    ),
                  ],
                ),
              ),
            ],
          ),
          // child: Center(
          //   child: MyNormalButton(
          //     width: 120,
          //     height: 120,
          //     onClick: () {},
          //     child: Text("HelloWorld!"),
          //   ),
          // ),
        ),
        Container(
          width: 300,
          height: 120,
          color: Colors.amber,
        ),
      ],
    );
  }
}
