import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:my_chat_app/screens/chat_screen.dart';
import 'package:my_chat_app/utils/global_variables.dart';
import 'package:my_chat_app/widgets/my_button.dart';
import 'package:my_chat_app/widgets/my_textfield.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();
  bool isAsync = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: isAsync,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/logo.png',
                fit: BoxFit.fill,
                height: 200,
              ),
              const SizedBox(
                height: 15,
              ),
              MyTextField(
                textEditingController: emailController,
                hintText: 'Enter your email',
              ),
              const SizedBox(
                height: 15,
              ),
              MyTextField(
                textEditingController: passwordController,
                hintText: 'Enter your password',
              ),
              const SizedBox(
                height: 15,
              ),
              MyButton(
                backgroundColor: mainColor,
                onPressed: () async {
                  String email = emailController.text;
                  String password = passwordController.text;
                  setState(() {
                    isAsync = true;
                  });
                  try {
                    UserCredential cred = await FirebaseAuth.instance
                        .signInWithEmailAndPassword(
                            email: email, password: password);
                    setState(() {
                      isAsync = false;
                    });
                    // ignore: use_build_context_synchronously
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ChatScreen(),
                      ),
                    );
                  } catch (e) {
                    setState(() {
                      isAsync = false;
                    });
                    print(e.toString());
                  }
                },
                text: 'Login',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
