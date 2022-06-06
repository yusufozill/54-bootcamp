import 'package:antello/classes/app_user.dart';
import 'package:antello/widgets/user_chart.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../themes/app_colors.dart';

class ExploreTab extends StatefulWidget {
  const ExploreTab({ Key? key }) : super(key: key);

  @override
  State<ExploreTab> createState() => _ExploreTabState();
}

class _ExploreTabState extends State<ExploreTab> {
    Map<AppUser,Widget> _i = {};
  
  List<Widget> userCharts(int s){
    if(_i.isNotEmpty) return  _i.values.toList();
    _i = {};
    for(var i in UserMAnagement.allusers){

      _i.addAll({i: UserChart(appUser: i)});

    }
    
    // while(_i.length<s){
    //   _i.add(UserChart(appUser: UserMAnagement.sampleUser));
      
    // }
    List<Widget> k= _i.values.toList();
    k.shuffle();
    
    return k;
  }
  @override
  void initState() {
    // TODO: implement initState
    UserMAnagement.randomUser(5).then((value) => setState(() {
      
    },));
    UserMAnagement.user= FirebaseAuth.instance.currentUser;

    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor:AppColors.purple,
          title:Text("Formica",style:GoogleFonts.comfortaa(
            fontSize:23,
            fontWeight:FontWeight.bold,
          ),),
        ),
        body: SingleChildScrollView(
        child: Column(children: userCharts(5) ,),
      ),
    );
  }
}