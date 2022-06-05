import 'package:antello/classes/gender_questions.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class NewUser {
  static Answers gender = Answers(cevap: "cevap");
  static DateTime birthday = DateTime(2007);
  static String department = "";
  static String name = "";
  static String surname = "";
  static String nickname = "";
  static String mail = "";
  static String password = "";
  static String bio = "";

  static String uid = "";
  static SnackBar customSnackBar({required String content}) {
    return SnackBar(
      backgroundColor: Colors.black,
      content: Text(
        content,
        style: const TextStyle(color: Colors.white, letterSpacing: 0.5),
      ),
    );
  }
  
  static bool control(){
  return true;
   




  }
  static olustur() {
    Map<String, dynamic> newmap = {};
    newmap.addAll(
        {
         "name": name,
        "surname": surname,
        "department": department,
        "gender": gender.toString(),
        "birthday": birthday.toString(),
        "messages":{},
        "nickname": nickname,
        "bio": bio,
        "url":"",

       
      },
    );
    final database = FirebaseDatabase.instance;
    
    DatabaseReference messagesRef = database.ref('Users/$nickname');
     database.ref('uids/$uid').update({
        "mail": mail,
        "nickname":nickname,
        nickname:true,
        uid.toString(): true,
        "password": password,
        "public":newmap,
    });

    messagesRef.update(newmap).then((value){ print("newuser Oluşturuldu");});
   
  }
}

