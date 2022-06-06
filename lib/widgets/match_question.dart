

import 'package:antello/classes/app_user.dart';
import 'package:antello/classes/match_question_class.dart';
import 'package:antello/classes/message.dart';
import 'package:antello/classes/new_user_informations.dart';
import 'package:antello/themes/app_colors.dart';
import 'package:antello/widgets/photo_chart.dart';
import 'package:antello/widgets/purple_button.dart';
import 'package:flutter/material.dart';

import '../classes/sohbet.dart';
import '../screens/chat_screen.dart';

class MatchQuestionWidget extends StatefulWidget {
  final MatchQuestion matchQuestion;
  const MatchQuestionWidget({ Key? key,required this.matchQuestion }) : super(key: key);

  @override
  State<MatchQuestionWidget> createState() => _MatchQuestionWidgetState();
}

class _MatchQuestionWidgetState extends State<MatchQuestionWidget> {
  late MatchQuestion matchQuestion ;
   AppUser? user;

  @override
  void initState()  {
   matchQuestion=widget.matchQuestion;
     UserMAnagement.fromUsername(matchQuestion.owner).then((value) => user =value);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(boxShadow: [BoxShadow(   color: Colors.grey.withOpacity(0.5),
        spreadRadius: 1,
        blurRadius:10,
        offset: Offset(5,15),)]),
      child: Stack(
        children:[ Container(
          padding: const EdgeInsets.all(8),
          margin: const EdgeInsets.all(8),
          constraints: BoxConstraints(minHeight:150,maxWidth:size.width),

          decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(10)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,

            children: [
            Row(children: [
              SizedBox(
                width: 50,
                height:50,
                child: PhotoChart(appUser: widget.matchQuestion.owner),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(matchQuestion.owner),
              ),
              const Expanded(child: SizedBox()),
              Text("${matchQuestion.shareTime.day}/${matchQuestion.shareTime.month}/${matchQuestion.shareTime.year}")
            ],),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(matchQuestion.question, maxLines: 3, textAlign: TextAlign.center, style: TextStyle(overflow: TextOverflow.ellipsis, ), ),
          ),

      
          Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: PurpleButton(answer: matchQuestion.first, function: (_x){
                         cevapla(true);},),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: PurpleButton(answer: matchQuestion.second, function: (_x){
                          cevapla(false);
                         },),
                      ),
                    ),
                  ],
                ),
        

          ],),

        )],
      ),
    );
  }

  cevapla(bool cevap) async{
    
     if(user==null) return;
     var  k = await user!.dialogKur(UserMAnagement.sender!);
                   if(k !=""){
                     Sohbet newSohbet=Sohbet(chatId:k,giver: user!.nickname,sender: UserMAnagement.sender!);
                  String  hasan() {
                    switch (matchQuestion.trueAnswer == cevap) {
                      case true : return "${user!.nickname} beklediğin cevabı verdi";
                      case false :return "${user!.nickname} sorun hakkında farklı düşünüyor";
                        
    
                    }
                    return "${user!.nickname} sorunu cevapladı";
                  };
                  String benimcevabim(){
                    if(matchQuestion.trueAnswer){
                      return "'"+ matchQuestion.question +"'" +" : '"+ matchQuestion.first+"'";
                    } else{
                      return "'"+ matchQuestion.question +"'" +" : '"+ matchQuestion.second+"'";

                    }
                  }
                 newSohbet.sendMessage(Message(mesaj: hasan(), time: DateTime.now(), sender:  UserMAnagement.sender!));
                 newSohbet.sendMessage(Message(mesaj: benimcevabim() , time: DateTime.now(), sender:  UserMAnagement.sender!));
                 Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ChatScreen(
              sohbet:newSohbet,
            )));
  }}
}