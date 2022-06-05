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
        constraints: const BoxConstraints(minWidth: 60),
        alignment: Alignment.center,

        padding: const EdgeInsets.all(8),
        decoration:BoxDecoration(color: AppColors.purple, borderRadius: BorderRadius.circular(100)),
        child: Text(answer, style:const TextStyle(color: AppColors.white)),
      ),
    );
  }
}