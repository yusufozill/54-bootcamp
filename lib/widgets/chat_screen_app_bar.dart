import 'package:antello/widgets/photo_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../themes/app_colors.dart';

AppBar ChatScreenAppBar(String appUser) =>
AppBar(
    actions: [PhotoChart(appUser: appUser)],
    centerTitle: true,
    backgroundColor:AppColors.purple,
    title:Text("Formica",style:GoogleFonts.comfortaa(
      fontSize:23,
      fontWeight:FontWeight.bold,
    )
    )
);
