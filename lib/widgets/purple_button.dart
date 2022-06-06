import 'package:antello/themes/app_colors.dart';
import 'package:flutter/material.dart';

class PurpleButton extends StatelessWidget {
  final String answer;
  final void Function(String)  function;
  const PurpleButton({ Key? key , required this.answer, required this.function}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {function(answer);},
        child: Container(

          constraints: const BoxConstraints(minWidth:60),
          alignment: Alignment.center,

          padding: const EdgeInsets.all(8),
          decoration:BoxDecoration(color: AppColors.purple, borderRadius: BorderRadius.circular(100),boxShadow: [
          BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 5,
          blurRadius: 7,
          offset: Offset(0, 3), // changes position of shadow
        ),]),
          child: Text(answer,maxLines:3,textAlign:TextAlign.center,style:const TextStyle(color: AppColors.white,overflow: TextOverflow.ellipsis)),
        ),
      );

  }
}