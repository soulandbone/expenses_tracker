import 'package:flutter/material.dart';

class TitleTF extends StatelessWidget {
  const TitleTF(this.controller, {super.key});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLength: 50,
      decoration: const InputDecoration(label: Text('Title')),
    );
  }
}
