import 'dart:ui';
import 'package:antello/themes/app_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../main.dart';

class LoginWidget extends StatefulWidget {
  final Function(bool, bool) onclickedSignUp;


  const LoginWidget({Key? key, required this.onclickedSignUp})
      : super(key: key);

  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  bool isCompleted=false;
  String? hata;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                TextField(
                  controller: emailController,
                  cursorColor: Colors.white,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    labelText: "E-posta",
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                TextField(
                  controller: passwordController,
                  textInputAction: TextInputAction.done,
                  decoration: const InputDecoration(labelText: "Şifre"),
                  obscureText: true,
                ),
                const SizedBox(
                  height: 40,
                ),
                ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                         primary: AppColors.purple,
                        minimumSize: const Size.fromHeight(50),shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(20))),
                    onPressed: signIn,
                    icon: const Icon(FontAwesomeIcons.lock,),
                    label: const Text("Giriş yap")),
                const SizedBox(
                  height: 40,
                ),
                InkWell(
                  onTap: () {
                    widget.onclickedSignUp(false, true);
                  },
                  child: const Text(
                    "Kayıt ol",
                    style: TextStyle(
                        fontSize: 15,
                        color: AppColors.purple,
                        decoration: TextDecoration.underline),
                  ),
                ),
              ],
            ),
          ),

        ],
      );

  }

  Future signIn() async {

    // showDialog(
    //  context: context,
    //  builder: ((context) => const Center(
    //    child: CircularProgressIndicator(),
    //   )));

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
    } on FirebaseAuthException catch (e) {
      hata=e.toString();
      debugPrint(hata.toString());
    }

    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
