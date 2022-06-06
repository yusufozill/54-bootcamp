import 'dart:ui';
import 'package:antello/classes/app_user.dart';
import 'package:antello/screens/sign_in_screen.dart';
import 'package:flutter/material.dart';
import '../widgets/profile_appbar.dart';
import '../widgets/profile_widget.dart';

class ProfileTab extends StatefulWidget {
     String? username;
   ProfileTab({Key? key, this.username}) : super(key: key);

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  @override
  void initState() {
   
 
    super.initState();
       debugPrint("profil tab");
        if( widget.username!=null) return;
    debugPrint("const boş");

        if (UserMAnagement.username==null) {
    debugPrint("offline");

     // Navigator.of(context).pushNamed("/SignIn");
      return;
    }
    debugPrint("online");

    widget.username=UserMAnagement.username;
 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFFF7F7FC),
      //  appBar: profileAppBar,
        body:  widget.username==null ? Align( alignment: Alignment.topCenter, child: const SignInScreen()): ProfileWidget(username: widget.username!,),

    );
  }
}
