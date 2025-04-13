import 'package:flutter/material.dart';

class MyTextInput extends StatefulWidget {
  final String text;
  final Color? color;
  const MyTextInput({super.key, required this.text, this.color});
  @override
  State<MyTextInput> createState() => _MyTextInputState();
}

class _MyTextInputState extends State<MyTextInput> {
  @override
  Widget build(BuildContext context) {
    return Text("");
  }
}
