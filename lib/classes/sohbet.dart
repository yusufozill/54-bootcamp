import 'dart:html';

import 'package:antello/classes/message.dart';
import 'package:firebase_database/firebase_database.dart';

class Sohbet{
  String sender;
  String giver;
  String chatId;
  Sohbet({required this.chatId,required this.giver, required this.sender});
    sendMessage(Message mesaj, ){
      if(mesaj.mesaj==""){
        mesaj.mesaj="";
      }
    FirebaseDatabase.instance.ref().child("messages/$chatId/messages").update({DateTime.now().millisecondsSinceEpoch.toString()+mesaj.sender:
    mesaj.toMap()});
}}