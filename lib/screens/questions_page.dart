import 'package:antello/widgets/birthday_widget.dart';
import 'package:antello/widgets/gender_widget.dart';
import 'package:antello/widgets/introduction_widget.dart';
import 'package:antello/widgets/pp_upload.dart';
import 'package:antello/widgets/study_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../classes/new_user_informations.dart';
import '../themes/app_colors.dart';
import '../widgets/push_button.dart';


class QuestionsPage extends StatefulWidget {
  User? user;
    QuestionsPage({Key? key,
   this.user
  }) : super(key: key);

  @override
  _QuestionsPageState createState() => _QuestionsPageState();
}

class _QuestionsPageState extends State<QuestionsPage> {
  int currentstep = 0;
  PageController pageController = PageController(initialPage: 0);
  List<Widget> list= [
                  //name surname
                  //
                  const GenderWidget(),
                  const BirthdayWidget(),
                  const StudyWidget(),
                  const SingleChildScrollView(child: IntroduceWidget()),
                  PPUpload(  username: NewUser.nickname),
                ];
  @override
  void initState() {
   

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.purple,
        title: Text(
          "Formica",
          style: GoogleFonts.montserrat(
            color: AppColors.yellow,
            fontSize: 24,
            fontStyle: FontStyle.italic,
          ),
        ),
        // actions: [
        //   IconButton(
        //       onPressed: () {
        //         pageController.previousPage(
        //             duration: const Duration(milliseconds: 10),
        //             curve: Curves.bounceInOut);
        //       },
        //       icon: const Icon(FontAwesomeIcons.angleLeft)),
        //   IconButton(
        //       onPressed: () {
        //         pageController.nextPage(
        //             duration: const Duration(milliseconds: 10),
        //             curve: Curves.bounceInOut);
        //       },
        //       icon: const Icon(FontAwesomeIcons.angleRight))
        // ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(children: [
            StepProgressIndicator(
              totalSteps: list.length-1,
              currentStep:currentstep,
              size: 5,
              padding: 0,
              selectedColor: AppColors.purple,
              unselectedColor: Colors.grey,
              roundedEdges: const Radius.circular(10),
            ),
            const SizedBox(
              height: 50,
            ),
            Expanded(
              flex: 3,
              child: PageView(
                onPageChanged: (value){
                  currentstep=value;
                  setState(() {
                    
                  });
                },
              
                pageSnapping: true,
                controller: pageController,
                children: list,
              ),
            ),
            Expanded(
              flex: 1,
              child:  
         Row(
           mainAxisAlignment: MainAxisAlignment.spaceAround,
           children: [
       ... currentstep==0?[]:     [PushButton(
               textColor:  Colors.black,
              backgroundColor: Colors.grey, 
               butonyazisi:"Önceki",
             width: 200,
               function:() {
                    pageController.previousPage(
                    duration: const Duration(milliseconds: 10),
                    curve: Curves.bounceInOut);
             
              
        }
        ),],
          
               PushButton(butonyazisi:currentstep==list.length-1 ?"Tamamla":"Sonraki",
             width: 200,

               function:() {
                    
                    pageController.nextPage(
                    duration: const Duration(milliseconds: 10),
                    curve: Curves.bounceInOut);
                  
                //     if(pageController.page!<3) return;
                //     NewUser.uid=widget.user.uid;
                // NewUser.olustur();
                // Navigator.of(context).pushNamed("/");
        }
    
             ),
           ],
         )
       )  
          ]),
        ),
      ),
    );
  }
}
