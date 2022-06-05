
import 'package:antello/classes/app_user.dart';
import 'package:antello/themes/app_colors.dart';
import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:flutter/material.dart';

class Message {
  late String mesaj;
  late DateTime time;
  late String sender;
 
 Message({required this.mesaj,required this.time,required this.sender});
 Message.fromMap(Map map){
   mesaj=map["mesaj"];
   time= DateTime.fromMillisecondsSinceEpoch( map["time"]) ;
   sender=map["sender"];
 }
 Map toMap(){
  return {"mesaj":mesaj,"time":time.millisecondsSinceEpoch,"sender":sender};
 }

 Widget toWidget(){

   return   BubbleSpecialTwo(
                    text: mesaj,
                    tail: false,
                    color:  sender==UserMAnagement.sender ? const Color(0xFFE8E8EE): AppColors.purple,
                    delivered: true,
                    textStyle:  sender==UserMAnagement.sender ? TextStyle(color: AppColors.purple):TextStyle(color: AppColors.white),
                    isSender:sender==UserMAnagement.sender,
                  );
   
 }
}


