import 'dart:async';
import 'package:antello/classes/message.dart';
import 'package:antello/themes/app_colors.dart';
import 'package:antello/widgets/photo_chart.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../classes/app_user.dart';
import '../classes/sohbet.dart';
import '../screens/chat_screen.dart';

class ChatCard extends StatefulWidget {
  final String chatId;
  final String username;
  const ChatCard({Key? key, required this.chatId, required this.username})
      : super(key: key);

  @override
  State<ChatCard> createState() => _ChatCardState();
}

class _ChatCardState extends State<ChatCard> {
  late String uid;
  Message mesaj = Message(mesaj: "...", time:DateTime.now(), sender: "sender");
  List<Widget> messagelist = [];
  Map<String, String> myMessages = {};
  late DatabaseReference _messagesRef;
  TextEditingController mesajcontroller = TextEditingController();
  late StreamSubscription<DatabaseEvent> _messagesSubscription;
  AppUser user = AppUser(
      department: "",
      gender: "",
      birthDate: DateTime.now(),
      ad: "",
      soyad: "",
      nickname: "",
      url: "",
      bio: "");
  @override
  void initState() {
    // TODO: implement initState
    init();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _messagesSubscription.cancel();
    super.dispose();
  }

  init() async {
    if (UserMAnagement.username == "") return;

    FirebaseDatabase database = FirebaseDatabase.instance;
    _messagesRef =
        database.ref("messages").child(widget.chatId).child("messages");

    final messagesQuery = _messagesRef.limitToLast(1);

    _messagesSubscription =
        messagesQuery.onChildAdded.listen((DatabaseEvent event) {
      debugPrint('Child added: ${event.snapshot.value}');
      mesaj = Message.fromMap(event.snapshot.value as Map);

      (Object o) {
        final error = o as FirebaseException;
        debugPrint('Error: ${error.code} ${error.message}');
      };
    });
    var a =
        await FirebaseDatabase.instance.ref("Users/${widget.username}").once();
    user = AppUser.fromMap(a.snapshot.value as Map);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        debugPrint("h");
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ChatScreen(
            sohbet: Sohbet(
                chatId: widget.chatId,
                giver: user.nickname,
                sender: UserMAnagement.sender!),
          ),
        ));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Row(
          children: [
            Stack(
              children: [
                 PhotoChart(
                  maxsize:60,
                  appUser: "user",
                ),
                // if (yazisma.isActive)
                //   Positioned(
                //     right: 0,
                //     bottom: 0,
                //     child: Container(
                //       height: 20,
                //       width: 20,
                //       decoration: BoxDecoration(
                //           color: Colors.green,
                //           shape: BoxShape.circle,
                //           border: Border.all(color: Colors.white, width: 3)),
                //     ),
                //   )
              ],
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.nickname,
                    style: GoogleFonts.raleway(
                      fontSize: 20,
                      color: AppColors.purple,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Opacity(
                      opacity: 0.75,
                      child: Text(
                        mesaj.mesaj,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      )),
                ],
              ),
            )),
            Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
              Opacity(opacity: 0.75, child:Text(DateFormat("KK:mm").format(mesaj.time))),
              const SizedBox(
                height:5
              ),
              Container(
                height: 20,
                width: 20,
                child: Center(
                    child: Text(
                  "1",
                  style: GoogleFonts.raleway(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                  ),
                )),
                decoration: const BoxDecoration(
                  color: AppColors.purple,
                  shape: BoxShape.circle,
                ),
              ),
    ]),
          ],
        ),
      ),
    );
  }
}
