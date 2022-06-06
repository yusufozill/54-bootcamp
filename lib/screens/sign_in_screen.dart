import 'package:antello/classes/app_user.dart';
import 'package:antello/themes/app_colors.dart';
import 'package:antello/widgets/push_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/login_widget.dart';
import '../widgets/sign_up.dart';

class SignInScreen extends StatefulWidget {
  final Function() singin;
  const SignInScreen({Key? key, required this.singin }) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

bool yenibool = false;

class _SignInScreenState extends State<SignInScreen> {
  @override
  void initState() {
    debugPrint("sign in screen");

    FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      if (user == null) {
        debugPrint('User is currently signed out!');
      } else {
        //       UserMAnagement.fromUid(user.uid).then((value) {

        //         if(value.department!=""){
        //               Navigator.of(context).pushNamed("/");

        //         }else {
        // Navigator.of(context).pushReplacement(
        //         MaterialPageRoute(
        //           builder: (context) => QuestionsPage(
        //             user: user,
        //           ),
        //         ),
        //       );
        //         }
        //       });

        // Navigator.of(context).pushReplacement(
          await UserMAnagement.setupFromUid(user.uid);
          widget.singin();
        debugPrint('User is signed in!');
        
      }
    });

    super.initState();
  }

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }

  bool signin = false, signup = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(children:const [ Expanded(child:  Text(""))],),
            const Image(
              image: const AssetImage("assets/icon.png"),
              width: 400,
            ),
            const SizedBox(height: 80),

            // SizedBox (width:250,height: 250,child: Image.asset("assets/icon.png")),
            //    const Expanded(child: Text(""),),

            !signin
                ? const Text("")
                : LoginWidget(
                    onclickedSignUp: toggle,
                  ),
            !signup
                ? const Text("")
                : SignUp(
                    onClickedSignIn: toggle,
                  ),
            signin || signup
                ? const Text("")
                : PushButton(
                    backgroundColor: AppColors.purple,
                    butonyazisi: "Giriş Yap",
                    function: () {
                      setState(() {
                        signin = true;
                        signup = false;
                      });
                    },
                  ),
            const SizedBox(height: 20),

            signup || signin
                ? const Text("")
                : PushButton(
                    textColor: AppColors.purple,
                    backgroundColor: AppColors.background,
                    butonyazisi: "Kayıt Ol",
                    function: () {
                      setState(() {
                        signin = false;

                        signup = true;
                      });
                    },
                  ),
            const SizedBox(height: 20),

            // FutureBuilder(
            //   future: Authentication.initializeFirebase(context: context),
            //   builder: (context, snapshot) {
            //     if (snapshot.hasError) {
            //       return const Text('Error initializing Firebase');
            //     } else {
            //       return GoogleSignInButton(
            //         const Key("GoogleSignInButton"),
            //         girildimi: bekleyecekmiyiz,
            //       );
            //     }
            //   },
            // ),

            InkWell(
              onTap: () {
                _launchInBrowser(Uri(
                    scheme: 'https',
                    host: 'antello.firebaseapp.com',
                    path: ''));
              },
              child: const Text(
                "Gizlilik Politikası",
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    decoration: TextDecoration.underline),
              ),
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  void toggle(bool sin, bool up) => setState(() {
        signin = sin;
        signup = up;
      });
}
