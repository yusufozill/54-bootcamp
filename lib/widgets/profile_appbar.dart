import 'package:antello/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

AppBar profileAppBar=
    AppBar(
    // actions: [
    //   IconButton(onPressed: () {},
    //       icon: const Icon(FontAwesomeIcons.pen, color: AppColors.purple,))
    // ],
    backgroundColor: Colors.white,
    leading: const BackButton(color: AppColors.purple,),
    centerTitle: true,
    title: Text(
      "Profile",
      style: GoogleFonts.raleway(
        fontSize: 25,
        fontStyle: FontStyle.italic,
        color: AppColors.purple,
      ),
    ),
  );
