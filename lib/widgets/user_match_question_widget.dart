import 'package:antello/classes/app_user.dart';
import 'package:antello/classes/match_question_class.dart';
import 'package:antello/themes/app_colors.dart';
import 'package:antello/widgets/photo_chart.dart';
import 'package:antello/widgets/purple_button.dart';
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
                child: PhotoChart(appUser: widget.user),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(widget.user.ad + " " + widget.user.soyad),
              ),
              const Expanded(child: SizedBox()),
              Text(DateTime.now().toString())
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(children: [
              Expanded(
                  flex: 3,
                  child: TextField(
                    controller: questionController,
                  )),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      fixedSize: const Size(50, 50),
                      primary: Colors.yellow,
                      elevation: 6,
                      shape: const CircleBorder()),
                  onPressed: () => {
                        
                        gonder(),
                        print(firstAnswer.text),
                        print(secondAnswer.text)
                      },
                  child: const Text(
                    "+",
                  ))
            ]),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                  },
                  child: Container(
                    constraints: const BoxConstraints(minWidth: 60),
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                        color: AppColors.purple,
                        borderRadius: BorderRadius.circular(100)),
                    child: TextField(
                      textAlign: TextAlign.center,
                      controller: firstAnswer,
                      style: const TextStyle(color: AppColors.white),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  constraints: const BoxConstraints(minWidth: 60),
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: AppColors.purple,
                      borderRadius: BorderRadius.circular(100)),
                  child: TextField(
                      textAlign: TextAlign.center,
                      controller: secondAnswer,
                      style: const TextStyle(color: AppColors.white)),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
