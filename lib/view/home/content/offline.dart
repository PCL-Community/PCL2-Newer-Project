import 'package:flutter/material.dart';
import 'package:pcl2_newer/logic/change_body.dart';

class Offline extends StatefulWidget {
  const Offline({super.key});
  @override
  State<Offline> createState() => _OfflineState();
}

class _OfflineState extends State<Offline> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          ElevatedButton(
            onPressed: () =>
                setState(() => darkModeListen.value = !darkModeListen.value),
            child: Text("切换深色"),
          ),
        ],
      ),
    );
  }
}
