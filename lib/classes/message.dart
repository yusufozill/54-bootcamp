
import 'package:antello/classes/app_user.dart';
import 'package:antello/themes/app_colors.dart';
import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:flutter/material.dart';

class Message {
  late String mesaj;
  late DateTime time;
  late String sender;
  late bool isRead;
 
 Message({required this.mesaj,required this.time,required this.sender, this.isRead =false});
 Message.fromMap(Map map){
   mesaj=map["mesaj"];
   time= DateTime.fromMillisecondsSinceEpoch( map["time"]) ;
   sender=map["sender"];
   isRead=map["isRead"];
 }
 Map toMap(){
  return {"mesaj":mesaj,"time":time.millisecondsSinceEpoch,"sender":sender, "isRead":isRead};
 }

 Widget toWidget(){

   return   BubbleSpecialOne(
                    text: mesaj,
                    tail:false,
                    color:  sender==UserMAnagement.sender ?  AppColors.purple: const Color(0xFF9082EC),
                    delivered: true,
                    seen: isRead,
                    textStyle:  sender==UserMAnagement.sender ? TextStyle(color: Colors.white):TextStyle(color: AppColors.white),
                    isSender:sender==UserMAnagement.sender,
                  );
   
 }

}


