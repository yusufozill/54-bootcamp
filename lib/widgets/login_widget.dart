import 'dart:ui';
import 'package:antello/themes/app_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../main.dart';

class LoginWidget extends StatefulWidget {
  final Function(bool, bool) onclickedSignUp;

  const LoginWidget({Key? key, required this.onclickedSignUp})
      : super(key: key);

  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  bool isCompleted = false;
  String hata="";
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
                decoration: InputDecoration(
                  border: OutlineInputBorder(
    borderRadius:BorderRadius.circular(20),
    borderSide: BorderSide(
      color: AppColors.purple,

    )),
                  labelText: "E-posta",
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              TextField(
                controller: passwordController,
                textInputAction: TextInputAction.done,
                decoration:  InputDecoration(
                  labelText: "Şifre",
                  border: OutlineInputBorder(
                    borderRadius:BorderRadius.circular(20),
                      borderSide: BorderSide(
                    color: AppColors.purple,

                  )),
                ),
                obscureText: true,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(hata, style: TextStyle(color: Colors.red),),
              ),
              
              const SizedBox(
                height: 40,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: AppColors.purple,
                      minimumSize: const Size.fromHeight(50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                  onPressed: signIn,

                  child: const Text("Giriş yap")),
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
      hata = e.toString().split("]")[1];
      setState(() {
        
      });
      debugPrint(hata.toString());
    }

    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
