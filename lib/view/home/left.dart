import 'package:flutter/material.dart';
import 'package:pcl2_newer/components/button/my_check_button.dart';
import 'package:pcl2_newer/logic/change_body.dart';

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
                  iconData: Icons.all_out,
                  text: "正版",
                  index: 1,
                  onPressed: () => currentAccountListen.value = 1,
                  isChecked: currentAccountListen.value == 1,
                ),
                MyCheckButton(
                  iconData: Icons.all_inbox,
                  text: "离线",
                  index: 2,
                  onPressed: () => currentAccountListen.value = 2,
                  isChecked: currentAccountListen.value == 2,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
