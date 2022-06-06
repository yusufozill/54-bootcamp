import 'package:antello/classes/new_user_informations.dart';
import 'package:antello/screens/questions_page.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../themes/app_colors.dart';
import '/utils/email_auth.dart';

class SignUp extends StatefulWidget {
  final Function(bool, bool) onClickedSignIn;
  const SignUp({Key? key, required this.onClickedSignIn}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final formKey = GlobalKey<FormState>();
  bool nickvalue = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  TextEditingController isim = TextEditingController(),
      soyisim = TextEditingController(),
      nick = TextEditingController(),
      password1 = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: TextFormField(
                controller: isim,
                validator: (email) =>
                    !(email != null && email != "") ? " Enter a name" : null,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius:BorderRadius.circular(20),
                  borderSide: BorderSide(
                    color: AppColors.purple,

                  )),
                  labelText: 'İsim',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: TextFormField(
                controller: soyisim,
                validator: (email) =>
                    !(email != null && email != "") ? " Enter a surname" : null,
                decoration: InputDecoration(
                  border:   OutlineInputBorder(
                    borderRadius:BorderRadius.circular(20),
                  borderSide: BorderSide(
                    color: AppColors.purple,

                  )),
                  labelText: 'Soyisim',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: TextFormField(
                controller: nick,
                validator: (username) {
                  if (!(username != null && username != "")) {
                    return " Enter a nickname";
                  }
                  if (nickvalue) return "Bu kullanıcı adı alınmış";

                  return null;
                },
                decoration:  InputDecoration(
                  border:   OutlineInputBorder(
                    borderRadius:BorderRadius.circular(20),
                  borderSide: BorderSide(
                    color: AppColors.purple,

                  )),
                  labelText: 'Kullanıcı Adı',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: TextFormField(
                controller: emailController,
                cursorColor: Colors.white,
                textInputAction: TextInputAction.next,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (email) =>
                    email != null && !EmailValidator.validate(email)
                        ? " Enter a valid email"
                        : null,
                decoration: InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(
                      borderRadius:BorderRadius.circular(20),
                      borderSide: BorderSide(
                        color: AppColors.purple,

                      )),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: TextFormField(
                controller: passwordController,
                textInputAction: TextInputAction.done,
                decoration:  InputDecoration(labelText: "password", border: OutlineInputBorder(
                    borderRadius:BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: AppColors.purple,

                    )),),
                obscureText: true,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (password) => password != null && password.length < 8
                    ? "enter min 8 characters"
                    : null,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: TextFormField(
                controller: password1,
                textInputAction: TextInputAction.done,
                decoration:  InputDecoration(labelText: "password again", border: OutlineInputBorder(
                    borderRadius:BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: AppColors.purple,

                    )),),
                obscureText: true,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (password) =>
                    password != null && password != password1.text
                        ? "iki şifre aynı olmalıdır"
                        : null,
              ),
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
                onPressed: signUp,

                child: const Text("Kayıt Ol")),
            const SizedBox(
              height: 40,
            ),
            InkWell(
              onTap: () {
                widget.onClickedSignIn(true, false);
              },
              child: const Text(
                "Giriş Yap",
                style: TextStyle(
                    fontSize: 15,
                    color: Color(0xFF26235C),
                    decoration: TextDecoration.underline),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future signUp() async {
    final database = FirebaseDatabase.instance;
    DatabaseReference messagesRef = database.ref('Users/${nick.text}');
    await messagesRef.once().then((value) {
      nickvalue = value.snapshot.exists;
      if (nickvalue) debugPrint("bu kullanıcı adı var");
    });
    final isValid = formKey.currentState!.validate();

    if (nickvalue) return;
    debugPrint("bu kullanıcı adı yok");

    if (!isValid) return;

    NewUser.mail = emailController.text;
    NewUser.password = passwordController.text;
    NewUser.name = isim.text;
    NewUser.surname = soyisim.text;
    NewUser.nickname = nick.text;
    showDialog(
        context: context,
        builder: ((context) => const Center(
              child: CircularProgressIndicator(),
            )));
    try {
      late User k;
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailController.text.trim(),
              password: passwordController.text.trim())
          .then((value) => k = value.user!);

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => QuestionsPage(user: k),
        ),
      );
    } on FirebaseAuthException catch (e) {
      debugPrint(e.toString());
      Email.showSnackBar(e.message);
    }
  }
}
