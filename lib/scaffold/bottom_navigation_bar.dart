import 'package:antello/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomNavigationWidget extends StatelessWidget {
  void Function(int) gopage;
  int currentIndex;
  BottomNavigationWidget(
      {Key? key, required this.gopage, required this.currentIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        selectedItemColor: AppColors.purple,
        unselectedItemColor: AppColors.purple.withOpacity(0.55),
        onTap: (value) {
          gopage(value);
        },
        currentIndex: currentIndex,
        items:const [
          BottomNavigationBarItem(
            icon:Icon(FontAwesomeIcons.compass,),
          label:"Keşfet"),
          BottomNavigationBarItem(
              icon: Icon(Icons.question_answer, ),
              label: "Soru Tahtası"),
          BottomNavigationBarItem(
              icon: Icon(Icons.chat, ),
               label: "Sohbet"),
          BottomNavigationBarItem(
              icon: Icon(Icons.person,),
               label: "Hesap"),
        ]);
  }
}
