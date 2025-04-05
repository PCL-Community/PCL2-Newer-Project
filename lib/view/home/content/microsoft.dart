import 'package:flutter/material.dart';
import 'package:pcl2_newer/components/button/my_normal_button.dart';

class Microsoft extends StatefulWidget {
  const Microsoft({super.key});
  @override
  State<Microsoft> createState() => _MicrosoftState();
}

class _MicrosoftState extends State<Microsoft> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(children: [
        Text("微软登录"),
        MyNormalButton(
          onClick: () {},
          width: 200,
          height: 50,
          child: Text("点我登录"),
        ),
      ]),
    );
  }
}
