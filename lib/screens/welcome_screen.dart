import 'package:flutter/material.dart';
import 'package:my_chat_app/utils/global_variables.dart';
import 'package:my_chat_app/widgets/my_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.png',
              fit: BoxFit.fill,
              height: 200,
            ),
            const Text(
              'MessageMe',
              style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w800,
                  color: Color.fromARGB(230, 19, 5, 71)),
            ),
            const SizedBox(
              height: 15,
            ),
            MyButton(
              backgroundColor: mainColor,
              onPressed: () {
                // go to login screen
                Navigator.pushNamed(context, '/login');
              },
              text: 'Login',
            ),
            const SizedBox(
              height: 15,
            ),
            MyButton(
              backgroundColor: secondColor,
              onPressed: () {
                Navigator.pushNamed(context, '/register');
              },
              text: 'Register',
            ),
          ],
        ),
      ),
    );
  }
}
