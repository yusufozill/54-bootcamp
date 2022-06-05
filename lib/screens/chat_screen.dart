import 'dart:async';
import 'package:antello/classes/app_user.dart';
import 'package:antello/classes/message.dart';
import 'package:antello/classes/sohbet.dart';
import 'package:antello/themes/app_colors.dart';
import 'package:antello/widgets/photo_chart.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../widgets/profile_appbar.dart';

class ChatScreen extends StatefulWidget {
  final Sohbet sohbet;
  const ChatScreen({
    Key? key,
    required this.sohbet,
  }) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late String uid;
  List<Widget> messagelist = [];
  late DatabaseReference _messagesRef;
  TextEditingController mesajcontroller = TextEditingController();
  late StreamSubscription<DatabaseEvent> _messagesSubscription;
  bool initialized = false;
  User? user;
  AppUser giver = AppUser(
      department: "",
      gender: "",
      birthDate: DateTime.now(),
      ad: "",
      soyad: "",
      nickname: "",
      url: "",
      bio: "");
  @override
  void dispose() {
    // TODO: implement dispose
    // _counterSubscription.cancel();
    super.dispose();
    if (user == null) return;

    _messagesSubscription.cancel();
  }

  @override
  void initState() {
    // TODO: implement initState
    user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      debugPrint("chat screen kullanıcı boş");
      Navigator.of(context).pop();
    } else {
      uid = user!.uid;
      UserMAnagement.uid = uid;
      debugPrint("kullanıcı dolu");
    }
    init();
    super.initState();
  }

  init() async {
    if (UserMAnagement.username == "") return;

    final database = FirebaseDatabase.instance;
    _messagesRef =
        database.ref("messages").child(widget.sohbet.chatId).child("messages");
    var u = (await database.ref("Users").child(widget.sohbet.giver).get()).value
        as Map;
    giver = AppUser.fromMap(u);
    UserMAnagement.username =
        (await database.ref("uids/$uid").child("nickname").get()).value
            as String;
    database.setLoggingEnabled(false);
    if (!kIsWeb) {
      database.setPersistenceEnabled(true);
      database.setPersistenceCacheSizeBytes(1000);
    }

    // if (!kIsWeb) {
    //   await _counterRef.keepSynced(true);
    // }

    // _counterSubscription = _counterRef.onValue.listen(
    //   (DatabaseEvent event) {
    //     setState(() {
    //       _error = null;
    //       _counter = (event.snapshot.value ?? 0) as int;
    //     });
    //   },
    //   onError: (Object o) {
    //     final error = o as FirebaseException;
    //     setState(() {
    //       _error = error;
    //     });
    //   },
    // );

    final messagesQuery = _messagesRef.limitToLast(25);

    _messagesSubscription = messagesQuery.onChildAdded.listen(
      (DatabaseEvent event) {
        debugPrint('Child added: ${event.snapshot.value}');

        setState(() {
          messagelist
              .add(Message.fromMap(event.snapshot.value as Map).toWidget());
        });
      },
      onError: (Object o) {
        final error = o as FirebaseException;
        debugPrint('Error: ${error.code} ${error.message}');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: profileAppBar,
        body: Align(
          alignment: Alignment.bottomCenter,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  reverse: true,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: messagelist,
                  ),
                ),
              ),
              Container(
                color: AppColors.background,
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                        child: TextFormField(
                      decoration: const InputDecoration(),
                      keyboardType: TextInputType.text,
                      maxLines: 5,
                      minLines: 1,
                      controller: mesajcontroller,
                    )),
                    IconButton(
                        onPressed: () {
                          widget.sohbet.sendMessage(Message(
                              mesaj: mesajcontroller.text,
                              time: DateTime.now(),
                              sender: widget.sohbet.sender));
                          mesajcontroller.text = "";
                          setState(() {});
                        },
                        icon: const Icon(Icons.send))
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
