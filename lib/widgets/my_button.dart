import 'package:flutter/material.dart';
import 'package:my_chat_app/utils/global_variables.dart';

class MyButton extends StatelessWidget {
  const MyButton(
      {super.key,
      required this.backgroundColor,
      required this.text,
      required this.onPressed});

  final Color backgroundColor;
  final String text;
  final void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              backgroundColor: backgroundColor,
              minimumSize: Size(double.infinity, 50)),
          onPressed: onPressed,
          child: Text(
            text,
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.w400),
          )),
    );
  }
}
