import 'package:antello/themes/app_colors.dart';
import 'package:antello/widgets/photo_chart.dart';
import 'package:antello/widgets/profile_appbar.dart';
import 'package:antello/widgets/send_message_buton.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../classes/app_user.dart';

class ProfileWidget extends StatefulWidget {
  final String username;
  
  const ProfileWidget({Key? key, required this.username}) : super(key: key);

  @override
  _ProfileWidgetState createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  AppUser? user;

    @override
  void initState() {
      UserMAnagement.fromUsername(widget.username).then((value)  {
        user=value;
        setState(() {
          
        });
      });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child: Scaffold(
        appBar: UserMAnagement.user==widget.username ? profileAppBar: null,
        body: user==null ? Center(child: CircularProgressIndicator(),) : Padding(
          padding: const EdgeInsets.only(
            top: 20,
          ),
          child: Center(
            child: Column(
              children: [
                 PhotoChart(appUser:user!.nickname),
                const SizedBox(
                  height: 15,
                ),
                Text(user!.ad + " " + user!.soyad),
                const SizedBox(
                  height: 30,
                ),
                Expanded(
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(50),
                          ),
                          color: AppColors.yellow,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 20,
                          ),
                          child: Container(
                            decoration: const BoxDecoration(
                                color: AppColors.purple,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(50),
                                  topRight: Radius.circular(50),
                                )),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const SizedBox(
                                  height: 30,
                                ),
                                SendMessage(giver:user!.nickname),
                                const SizedBox(
                                  height: 50,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 50, right: 50),
                                    child: Text
                                    (
                                      user!.bio,
                                      style: GoogleFonts.raleway(
                                        color: Colors.white,
                                      ),
                                    ),
                                ),
                                const SizedBox(
                                  height: 50,
                                ),Padding(
                                  padding: const EdgeInsets.only(left: 50, right: 50),
                                  child: Text("Cinsiyet: ${user!.gender}"
                                    ,
                                    style: GoogleFonts.raleway(
                                      color: Colors.white,
                                    ),
                                  ),
                                ), SizedBox(height: 50,),
                                Padding(
                                  padding: const EdgeInsets.only(left: 50, right: 50),
                                  child: Text("Çalışma Alanı: ${user!.department}"
                                    ,
                                    style: GoogleFonts.raleway(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 50,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 50, right: 50),
                                  child: Text(
                                    "${user!.birthDate.day}/${user!.birthDate.month}/${user!.birthDate.year}",

                                    style: GoogleFonts.raleway(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ))),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
