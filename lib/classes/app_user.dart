import 'package:antello/classes/match_question_class.dart';
import 'package:antello/classes/sohbet.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../screens/chat_screen.dart';

class AppUser {
  late String ad;
  late String soyad;
  late String bio;
  late String department;
  late String gender;
  late DateTime birthDate;
  late String nickname;
  late String url;
  String? chatID;

  AppUser(
      {required this.department,
      required this.gender,
      required this.birthDate,
      required this.ad,
      required this.soyad,
      required this.nickname,
      required this.url,
      required this.bio});
  AppUser.fromMap(Map<dynamic, dynamic> map) {
    if (kDebugMode) {
      debugPrint("nası ya");
    }
    department = map["department"];
    gender = map["gender"];
    birthDate = DateTime.fromMicrosecondsSinceEpoch(map["birthday"]);
    ad = map["name"];
    soyad = map["surname"];
    nickname = map["nickname"];
    url = map["url"];
    bio = map["bio"];
  }

  get context => null;

  Future<String> dialogKur(String sender) async {
    UserMAnagement.sender = sender;
    UserMAnagement.giver = nickname;
    if (kDebugMode) {
      debugPrint("from:$sender, to:$nickname");
    }

    var database = FirebaseDatabase.instance;

    if (chatID != null) return chatID!;
    if (kDebugMode) {
      debugPrint("salatalık $sender");
    }

    var a = (await database.ref("buddylists/$sender").get());
    if (kDebugMode) {
      debugPrint(a.value.toString());
    }

    if (a.value != null) {
      for (var u in (a.value as Map).entries) {
        if (u.value.entries.first.key == nickname) {
          if (kDebugMode) {
            debugPrint("bu kullanıcıyla daha önce diyalog kurulmuş");
          }
          chatID = u.value.entries.first.value;
          UserMAnagement.chatID = chatID;
          if (chatID == null) return "";

          if (chatID == nickname) return "";
          return chatID!;
        }
      }
    }

    // debugPrint("geldim");

    String? newChatId = database.ref("messages").push().key;
    if (kDebugMode) {
      debugPrint("newchat =$newChatId");
    }

    if (newChatId == null) return "";
    await database
        .ref("buddylists/$nickname/$newChatId")
        .update({sender: newChatId});
    await database.ref("messages/$newChatId").update({
      "users": {
        sender: true,
        nickname: true,
      },
      "messages": {}
    });
    if (sender != nickname)
      await database
          .ref("buddylists/$sender/$newChatId")
          .update({nickname: newChatId});
    chatID = newChatId;
    UserMAnagement.chatID = chatID;
    if (chatID == null) return "";

    if (chatID == nickname) return "";

    if (kDebugMode) {
      debugPrint("geldim");
    }

    if (kDebugMode) {
      debugPrint("from:$sender, to:$nickname");
    }

    return newChatId;
  }
}

class UserMAnagement {
  static List<AppUser> allusers = [];
  static String? username;
  static String? giver;
  static String? uid;
  static User? user;
  static AppUser? appUser;
  static String? chatID;
  static String? sender;

  static Future<List<AppUser>> randomUser(int count) async {
    allusers = [];
    var a = await FirebaseDatabase.instance.ref("Users").once();

    for (var i in a.snapshot.children) {
      if (kDebugMode) {
        debugPrint((i.value as Map).toString());
      }

      allusers.add(AppUser.fromMap(i.value as Map));
    }
    return allusers;
  }

 
  static Future<AppUser> fromUsername(String username) async {
    final database = FirebaseDatabase.instance;
    var messagesRef =
        (await database.ref('Users/$username').get()).value as Map;

    return AppUser.fromMap(messagesRef);
  }

   static sendAndShow(String? sender,String giver ,BuildContext context) async{
         if(sender==null) return;
         AppUser user = await UserMAnagement.fromUsername(giver);
         var k= await user.dialogKur(sender);

               if(k !=""){
                 Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ChatScreen(
              sohbet: Sohbet(chatId:k,giver: user.nickname,sender: sender),
            ),
          ),
        );

               }
   }

  static AppUser sampleUser = AppUser(
//    mail: "aldkadjaslkd",
      ad: "Lorem",
      soyad: "IPSUM",
      bio:
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
      nickname: "hasda",
      gender: "gender",
      department: "Department",
      birthDate: DateTime.now(),
      // uid: "sdadsa",
      url:
          "https://firebasestorage.googleapis.com/v0/b/antello.appspot.com/o/spotdatabase%2F1653946099214.jpg?alt=media&token=38906d6b-6045-4f58-8239-93f53b206c6d");
  static MatchQuestion sampleQuestion = MatchQuestion(
      first: "tesla",
      second: "edison",
      trueAnswer: false,
      owner: UserMAnagement.sampleUser.nickname,
      question: "Tesla mı Edison mu ?",
      shareTime: DateTime.now());
}
