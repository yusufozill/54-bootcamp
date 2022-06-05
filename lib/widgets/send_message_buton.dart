import 'package:antello/classes/app_user.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SendMessage extends StatelessWidget {
  final String giver;
  const SendMessage({Key? key, required this.giver}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style:ElevatedButton.styleFrom(
            primary: Color(0xFFF9082EC),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            )
        ),
        onPressed:(){
           
           UserMAnagement.sendAndShow(UserMAnagement.username!, giver, context);
            }, child:Text("Mesaj Gönder",style:GoogleFonts.raleway(
      
      color:Colors.white,
    ),));
  }
}
