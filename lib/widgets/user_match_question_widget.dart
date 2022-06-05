import 'package:antello/classes/app_user.dart';
import 'package:antello/classes/match_question_class.dart';
import 'package:antello/themes/app_colors.dart';
import 'package:antello/widgets/photo_chart.dart';
import 'package:antello/widgets/push_button.dart';
import 'package:flutter/material.dart';

class UserMatchQuestionWidget extends StatefulWidget {
  final Function(MatchQuestion) tamamfonk;
  final AppUser user;
  const UserMatchQuestionWidget(
      {Key? key, required this.user, required this.tamamfonk})
      : super(key: key);

  @override
  State<UserMatchQuestionWidget> createState() =>
      _UserMatchQuestionWidgetState();
}

class _UserMatchQuestionWidgetState extends State<UserMatchQuestionWidget> {
  TextEditingController questionController = TextEditingController(),
      firstAnswer = TextEditingController(),
      secondAnswer = TextEditingController();
      FocusNode qfocus=FocusNode(),firstfocus=FocusNode(),secondfocus=FocusNode();
      bool boola=true;

  gonder() {
    MatchQuestion yenisoru = UserMAnagement.sampleQuestion;
    widget.tamamfonk(yenisoru);
  }

  @override
  void initState() {

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    questionController.dispose();
    firstAnswer.dispose();
    secondAnswer.dispose();
 
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.all(8),
      constraints: const BoxConstraints(minHeight: 200),
      decoration: BoxDecoration(
          color: AppColors.white, borderRadius: BorderRadius.circular(50)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            children: [
              SizedBox(
                width: 50,
                height: 50,
                child: PhotoChart(appUser: widget.user.nickname),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(widget.user.ad + " " + widget.user.soyad),
              ),
             // const Expanded(child: Center(child: Text("Bir Soru Bırak"))),
            //  Text(DateTime.now().toString())
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(children: [
              Expanded(
                  flex: 3,
                  child: TextField(
                    focusNode: qfocus,
                         decoration: const InputDecoration( focusedBorder: InputBorder.none, focusColor: Colors.white  , hintText: "Bir Soru Sor"),
            textAlign: TextAlign.center,
            
            cursorColor: AppColors.purple,
                    controller: questionController,
                  )),
              // ElevatedButton(
              //     style: ElevatedButton.styleFrom(
              //         fixedSize: const Size(50, 50),
              //         primary: Colors.yellow,
              //         elevation: 6,
              //         shape: const CircleBorder()),
              //     onPressed: () => {
                        
              //           gonder(),
              //           print(firstAnswer.text),
              //           print(secondAnswer.text)
              //         },
              //     child: const Text(
              //       "+",
              //     ))
          
            ]),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InputMatch(controller: firstAnswer, focus: firstfocus, isThis: boola, funck: (){setState(() {
                boola=!boola;
              });},),
              InputMatch(controller: secondAnswer, focus:secondfocus,isThis: !boola, funck: (){setState(() {
                boola=!boola;
              });},),
            ],
          )
          , Padding(
            padding: const EdgeInsets.all(8.0),
            child: PushButton(function: (){
              MatchQuestion.fromthings(user: UserMAnagement.appUser!, soru: questionController.text, firstAnswer: firstAnswer.text, secondAnswer: secondAnswer.text, dogrucevap: boola);
               qfocus.unfocus();
    firstfocus.unfocus();
    secondfocus.unfocus();

             gonder();
            }, butonyazisi: "gönder", height:40 , width: 100, fontsize: 16,),
          ) 
        ],
      ),
    );
  }
}

class InputMatch extends StatelessWidget {

  const InputMatch({
    Key? key,
    required this.controller,
    required this.isThis,
    required this.focus,
    required this.funck,
  }) : super(key: key);

  final TextEditingController controller;
  final bool isThis;
  final FocusNode focus;
  final Function() funck;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: funck,
        child: Container(
          constraints: const BoxConstraints(minWidth: 60),
          alignment: Alignment.center,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: AppColors.purple,
              borderRadius: BorderRadius.circular(20)),
          child: Stack(
            children: [
              
              TextFormField(
                decoration: const InputDecoration(border: InputBorder.none, focusedBorder: InputBorder.none, focusColor: Colors.white),
                  textAlign: TextAlign.center,
                  
                  cursorColor: Colors.white,
                  controller: controller,
                  focusNode: focus,
                  style: const TextStyle(color: AppColors.white)),
            Align(
              alignment: Alignment.topRight,
              child: isThis? const Icon(Icons.check_box, color: Colors.white,) : const Icon(Icons.check_box_outline_blank, color: Colors.white,),
            )


            ],
          ),
        ),
      ),
    );
  }
}
