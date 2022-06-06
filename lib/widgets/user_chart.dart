
import 'package:antello/classes/app_user.dart';
import 'package:antello/classes/sohbet.dart';
import 'package:antello/screens/chat_screen.dart';
import 'package:antello/themes/app_colors.dart';
import 'package:antello/widgets/photo_chart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


///Arkadaşlar [UserChart]; [HomePage] içinde alt alta kullanıcı
///profil ve bilgilerinin görüntülenebilmesi için hazırlanan
/// Kullanıcı bilgi kartlarıdır
class UserChart extends StatelessWidget {

  /// Her bir User [AppUser] classından üretilen bir nesnedir. 
  /// Her bir [UserChart] bilgileri çekebileceği [AppUser] nesnesine
  /// ihtiyaç duyar. [appUser] isminin sebebi Auth user ile karışmaması için
  final AppUser appUser;

  const UserChart({Key? key, required this.appUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      ///Bu padding parent widget içinde bir padding oluşturur
      padding: const EdgeInsets.all(8.0),
      child: Container(
      ///Beyaz alt katman widgeti
        clipBehavior: Clip.hardEdge,
        padding: const EdgeInsets.only(top: 8),
        constraints: const BoxConstraints(maxHeight: 250),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius:  BorderRadius.only(
                bottomLeft:  Radius.circular(30),
                bottomRight: Radius.circular(30),
                topLeft:  Radius.circular(50),
                topRight: Radius.circular(50),
                )),
        child: Stack(
          children: [
            InkWell(
              onTap: () async{
                if(UserMAnagement.user==null){
                  if (kDebugMode) {
                    debugPrint("giriş yapılmamış");
                  }
                  return;
                }
             
              UserMAnagement.sendAndShow(UserMAnagement.username, appUser.nickname, context);

                if (kDebugMode) {
                  debugPrint("Pressed on widget");
                }
              },
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    decoration: const BoxDecoration(
                        color: AppColors.purple,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30))),
                    height: 50,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 12, right: 12, bottom: 12),
                      child: Container(
                        constraints: const BoxConstraints(maxHeight: 10),
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(30),
                                bottomRight: Radius.circular(30))),
                      ),
                    ),
                  )),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  /// User için profil fotoğrafı [PhotoChart]
                  PhotoChart(appUser: appUser.nickname,),
                  InkWell(
                    onTap: () {
                      if (kDebugMode) {
                        debugPrint("pressed on name");
                      }
                    },
                    child: Text(
                      appUser.ad + " " + appUser.soyad,
                      style: GoogleFonts.oswald(fontWeight: FontWeight.bold),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      if (kDebugMode) {
                        debugPrint("pressed on bio text");
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 16, right: 16, top: 8, bottom: 8),
                      child: Text(
                        "    " + appUser.bio,
                        style: GoogleFonts.oswald(fontWeight: FontWeight.w100),
                        textAlign: TextAlign.justify,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 4,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Column(
                  children: [
                    IconButton(
                      onPressed: () {
                        if (kDebugMode) {
                          debugPrint("pressed on close");
                        }
                      },
                      icon: const Icon(Icons.close),
                    ),
                    // IconButton(
                    //   onPressed: () {
                    //     debugPrint("pressed on information");
                    //   },
                    //   icon: const Icon(Icons.info),
                    // ),
              
                  ],
              
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}