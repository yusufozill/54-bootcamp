

import 'package:antello/classes/app_user.dart';
import 'package:antello/classes/match_question_class.dart';
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
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.all(8),
      constraints: const BoxConstraints(minHeight: 150),

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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [Text(matchQuestion.question)],),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            PurpleButton(answer: matchQuestion.first, function: (_x){
             cevapla(true);},),
            PurpleButton(answer: matchQuestion.second, function: (_x){
              cevapla(false);
             },),
          ],
        )
      ],),
      
    );
  }

  cevapla(bool cevap) async{
     if(matchQuestion.trueAnswer != cevap) return;
     if(user==null) return;
     var  k = await user!.dialogKur(UserMAnagement.sender!);
                   if(k !=""){
                 Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ChatScreen(
              sohbet: Sohbet(chatId:k,giver: user!.nickname,sender: UserMAnagement.sender!),
            )));
  }}
}