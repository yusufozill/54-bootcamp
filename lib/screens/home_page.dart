import 'dart:async';

import 'package:antello/classes/app_user.dart';
import 'package:antello/scaffold/bottom_navigation_bar.dart';
import 'package:antello/tabs/explore_tab.dart';
import 'package:antello/tabs/match_tab.dart';
import 'package:antello/tabs/profile_tab.dart';
import 'package:antello/themes/app_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/utils/stream_subscriber_mixin.dart';
import 'package:flutter/material.dart';
import '../tabs/chat_tab.dart';
import '../widgets/user_chart.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>  with TickerProviderStateMixin  {
  late TabController controller;
late StreamSubscription a ;
  @override
  void initState() {
    // TODO: implement initState

    controller= TabController(length: 4, vsync: this);
   a=   FirebaseAuth.instance.authStateChanges().listen((User? user) async{
      
      if (user == null) {
      
        debugPrint('User is currently signed out!');
      } else {
       var database= FirebaseDatabase.instance;
        UserMAnagement.user=user;
        UserMAnagement.sender=
        UserMAnagement.uid= user.uid;
        UserMAnagement.username= (await database.ref("uids/${UserMAnagement.uid}").child("nickname").get()).value as String;
        UserMAnagement.sender= UserMAnagement.username;
        UserMAnagement.appUser=AppUser.fromMap((await database.ref("Users").child(UserMAnagement.username!).get()).value as Map);
        print('User is signed in!');
      }
    });

   
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    a.cancel();
    controller.dispose();
    super.dispose();
  }
  

  int tabindex=2;
  List<Widget> tabs =[ExploreTab(),MatchTab(),ChatTab(),ProfileTab()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      bottomNavigationBar: BottomNavigationWidget( gopage: goPage, currentIndex: tabindex,)
,
      body: TabBarView( controller: controller, children: tabs,) );
  }

  
  goPage(int page){
    print("şu sayfaya geçildi $page");
    
    setState(() {
       tabindex= page;
    });

    controller.animateTo(page, duration: Duration(milliseconds:200));
    if(page==3){
    Navigator.of(context).pushNamed("/SignIn");

    }




  
}
}

