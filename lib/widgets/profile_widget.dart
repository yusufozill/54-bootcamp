import 'package:antello/themes/app_colors.dart';
import 'package:antello/widgets/photo_chart.dart';
import 'package:antello/widgets/profile_appbar.dart';
import 'package:antello/widgets/send_message_buton.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../classes/app_user.dart';

class ProfileWidget extends StatefulWidget {
  final String username;
  final Function? signin;
  
  const ProfileWidget({Key? key, required this.username, this.signin}) : super(key: key);

  @override
  _ProfileWidgetState createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  AppUser? user;

    @override
  void initState() {
      UserMAnagement.fromUsername(widget.username).then((value)  {
        user=value;
        setState(() {
          
        });
      });


    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return  Scaffold(
       appBar: widget.username ==UserMAnagement.username?null: profileAppBar,

        body: user==null ? const Center(child: CircularProgressIndicator(),) : Padding(
          padding: const EdgeInsets.only(
            top: 20,
          ),
          child: Center(
            child: Column(
              children: [
                 PhotoChart(appUser:user!.nickname),
                 

                 TextButton(onPressed: ()async{
                  await UserMAnagement.sinout().then((value) => print("gfjh"));
               if(widget.signin!=null){
                  widget. signin!();
              

               }
                   
                     user=null;
                 },
                  child:
                  widget.username ==UserMAnagement.username?Text(""):
                   Text("Çıkış Yap", style: TextStyle(color: AppColors.purple, decoration: TextDecoration.underline, fontSize: 15),)),
                const SizedBox(
                  height: 15,
                ),
                const SizedBox(
                  height: 30,
                ),
                Expanded(
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(50),
                          ),
                          color: AppColors.yellow,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 20,
                          ),
                          child: Container(
                            decoration: const BoxDecoration(
                                color: AppColors.purple,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(50),
                                  topRight: Radius.circular(50),
                                )),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [

                     
                          
                            
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text((user!.ad + " " + user!.soyad).toUpperCase() + " • (" +(DateTime.now().difference(user!.birthDate).inDays/365).toInt().toString()+")" , style: const TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: AppColors.white),),
                    ),
                 Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: Text(user!.gender.toUpperCase()
                                      ,
                                      style: GoogleFonts.raleway(
                                        color: Colors.white,
                                      ),),
                 ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                         widget.username !=UserMAnagement.username?  SendMessage(giver:user!.nickname):Text(""),

                                    ],)
                
                  ],
                ),

                            
       
                                Padding(
                                  padding: const EdgeInsets.only(left: 50, right: 50),
                                    child: Text
                                    (
                                      user!.bio ,
                                      style: GoogleFonts.raleway(
                                        color: Colors.white,
                                        fontSize: 20
                                      ),
                                      
                                    ),
                                ),
                    
                                Padding(
                                  padding: const EdgeInsets.only(left: 50, right: 50),
                                  child: Text(" ${user!.department}"
                                    ,
                                    style: GoogleFonts.raleway(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                            
                          
                              ],
                            ),
                          ),
                        ))),
              ],
            ),
          ),
        ),
      );
  
  }
}
