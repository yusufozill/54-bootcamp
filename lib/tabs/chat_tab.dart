import 'dart:async';

import 'package:antello/classes/app_user.dart';
import 'package:antello/classes/message.dart';
import 'package:antello/classes/sohbet.dart';
import 'package:antello/screens/chat_screen.dart';
import 'package:antello/widgets/chat_row.dart';
import 'package:antello/widgets/pp_upload.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ChatTab extends StatefulWidget {
  const ChatTab({Key? key}) : super(key: key);

  @override
  State<ChatTab> createState() => _ChatTabState();
}

class _ChatTabState extends State<ChatTab> {
  int _counter = 0;
  late String uid;
  List<Widget> messagelist = [];
  Map<String, String> myMessages = {};
  late DatabaseReference _messagesRef;
  TextEditingController mesajcontroller = TextEditingController();
  late StreamSubscription<DatabaseEvent> _messagesSubscription;
  User? user;
  @override
  void dispose() {
    // TODO: implement dispose
    // _counterSubscription.cancel();
    _messagesSubscription.cancel();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      print("user sing out");
    } else {
      uid = user!.uid;
      UserMAnagement.uid = uid;
    init();

    }
    super.initState();
  }

  init() async {

    if (UserMAnagement.username == "") return;
    if (UserMAnagement.username ==null) return;
    print("chatTabInıt");
    final database = FirebaseDatabase.instance;

       
    print("name: ${UserMAnagement.username}");

    UserMAnagement.sender = UserMAnagement.username;
    _messagesRef = database.ref("buddylists").child(UserMAnagement.sender!);
    _messagesRef.get().then((value) => print(value.value));

    database.setLoggingEnabled(false);
    if (!kIsWeb) {
      database.setPersistenceEnabled(true);
      database.setPersistenceCacheSizeBytes(1000);
    }

      final messagesQuery = _messagesRef.limitToLast(25);

    _messagesSubscription = messagesQuery.onChildAdded.listen(
      (DatabaseEvent event) {
        print('Child added: ${(event.snapshot.value as Map).entries.first.key}');
        print('Child added: ${(event.snapshot.value as Map).entries.first.value}');
        setState(() {
          
        
        messagelist.add ( ChatCard(
          username:(event.snapshot.value as Map).entries.first.key,
          chatId: (event.snapshot.value as Map).entries.first.value,
    
        ) );
          
        });

        
        
        


      },
      onError: (Object o) {
        final error = o as FirebaseException;
        print('Error: ${error.code} ${error.message}');
      },
    );

   
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: messagelist,
    );
  }
}
