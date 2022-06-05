import 'package:antello/themes/app_colors.dart';
import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';

class PushButton extends StatelessWidget {
  final void Function() function;
   final String butonyazisi;
   final double width;
   final double height;
   final double fontsize;
   final Color backgroundColor;
   final Color textColor;

   const PushButton({
    Key? key,
    required this.function,
    this.width=320,
    this.height=50,
    this.fontsize=24,
    required this.butonyazisi,
    this.backgroundColor= AppColors.purple ,
    this.textColor= Colors.white  ,
  }) : super(key: key);

  @override
  Widget build(context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            fixedSize: Size(width, height),
            primary: backgroundColor,
            onPrimary: textColor,
            elevation: 6,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            )),
        onPressed: function,
        child: Text(butonyazisi,
            style: GoogleFonts.raleway(
              fontSize: fontsize,
            )));
  }
}
