import 'dart:async';
import 'package:antello/classes/app_user.dart';
import 'package:antello/classes/match_question_class.dart';
import 'package:antello/widgets/match_question.dart';
import 'package:antello/widgets/regular_appbar.dart';
import 'package:antello/widgets/user_match_question_widget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
class MatchTab extends StatefulWidget {

 const MatchTab({ Key? key }) : super(key: key);

  @override
  State<MatchTab> createState() => _MatchTabState();
}

class _MatchTabState extends State<MatchTab> {
  late String uid;
  List<Widget> matchwidgets = [];
  Map<String, String> myMessages = {};
  late DatabaseReference _messagesRef;
  TextEditingController mesajcontroller = TextEditingController();
  late StreamSubscription<DatabaseEvent> _messagesSubscription;
  @override
  void dispose() {
    // TODO: implement dispose
    // _counterSubscription.cancel();
    _messagesSubscription.cancel();
    super.dispose();
  }



  init() async {

    debugPrint("chatTabInıt");
    final database = FirebaseDatabase.instance;

       
    debugPrint("name: ${UserMAnagement.username}");

    _messagesRef = database.ref("matchQuestions");
    _messagesRef.get().then((value) => debugPrint(value.value.toString()));

    database.setLoggingEnabled(false);
    if (!kIsWeb) {
      database.setPersistenceEnabled(true);
      database.setPersistenceCacheSizeBytes(1000);
    }

      final messagesQuery = _messagesRef.limitToLast(25);

    _messagesSubscription = messagesQuery.onChildAdded.listen(
      (DatabaseEvent event) {
        debugPrint('Child added: $event');
        setState(() {
      var _a=   MatchQuestion.fromMap(event.snapshot.value as Map);
      // if(_a.owner==UserMAnagement.username){
      //   matchwidgets.removeAt(0);
      // }
        matchwidgets.add(Padding(
          padding: const EdgeInsets.all(20.0),
          child: MatchQuestionWidget(matchQuestion: _a),
        ));
         
          
        });
        matchwidgets.shuffle();


        
        
        


      },
      onError: (Object o) {
        final error = o as FirebaseException;
        debugPrint('Error: ${error.code} ${error.message}');
      },
    );

   
  }

  @override
  void initState() {
      if  (UserMAnagement.user!=null){
    
    birincieleman=UserMatchQuestionWidget(user: UserMAnagement.appUser??UserMAnagement.sampleUser, tamamfonk:tamamfonk);
      
    

    }
 init();
    

    super.initState();
  }
  Widget birincieleman=const Text("");
  tamamfonk(MatchQuestion question){
 // birincieleman=MatchQuestionWidget(matchQuestion: question);
   setState(() {
     
   });

  }
  

 
    


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:RegularAppBar,
     body: SingleChildScrollView(
            child: Column(children: [ birincieleman] + matchwidgets ,),
          ),


    );
  }

}