import 'dart:html';

import 'package:antello/classes/app_user.dart';
import 'package:firebase_database/firebase_database.dart';

class MatchQuestion {
  late  DateTime shareTime;
  late  String owner;
  late  String question;
  late   String first;
  late   String second;
  late   bool trueAnswer;
    

   MatchQuestion({required this.first, required this.second, required this.owner, required this.question, required this.trueAnswer,required this.shareTime});

MatchQuestion.fromthings({   
 required  AppUser user,
 required   String soru,
  required  String firstAnswer,
  required  String secondAnswer,
  required  bool dogrucevap
}){
 
shareTime=DateTime.now();
owner=user.nickname;
question=soru;
first=firstAnswer;
 second=secondAnswer;
trueAnswer=dogrucevap;

FirebaseDatabase.instance.ref("matchQuestions").child(user.nickname).set({
  "question":soru,"firstAnswer":firstAnswer,"secondAnswer":secondAnswer, "answer":dogrucevap, "owner":user.nickname, "time" :shareTime.microsecondsSinceEpoch
}).then((value) => print("yeni mq gönderildi"));


}

MatchQuestion.fromMap(Map map){
  second=map["secondAnswer"];
  first=map["firstAnswer"];
  question=map["question"];
  shareTime=DateTime.fromMicrosecondsSinceEpoch(map["time"]);
  owner=map["owner"];
  trueAnswer=map["answer"];
  

   

}



}