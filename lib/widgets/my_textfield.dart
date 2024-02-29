import 'package:flutter/material.dart';
import 'package:my_chat_app/utils/global_variables.dart';

class MyTextField extends StatelessWidget {
  const MyTextField({
    super.key,
    required this.textEditingController,
    required this.hintText,
  });

  final TextEditingController textEditingController;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextField(
        textAlign: TextAlign.center,
        controller: textEditingController,
        cursorColor: secondColor,
        decoration: InputDecoration(
          hintText: hintText,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: mainColor, width: 1),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: mainColor, width: 2),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }
}
