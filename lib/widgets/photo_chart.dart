import 'package:antello/classes/open_route.dart';
import 'package:antello/tabs/profile_tab.dart';
import 'package:antello/themes/app_colors.dart';
import 'package:antello/widgets/profile_widget.dart';
import 'package:flutter/material.dart';


class PhotoChart extends StatefulWidget {
  String? appUser;
  String? url;
  Function()? fun; 
  final double maxsize;
   PhotoChart({Key? key, this.appUser, this.url,this.fun, this.maxsize =150}) : super(key: key);

  @override
  State<PhotoChart> createState() => _PhotoChartState();
}

class _PhotoChartState extends State<PhotoChart> {
   String? url(){
         if(widget. appUser != null) return widget.appUser!;
         if(widget.url =="") return null;

         if( widget.url != null) return widget.url!;
         return null;

      }
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        debugPrint("profile fotoğrafına basıldı");
        
      if(widget.fun!=null) {
        widget.fun!();
      };
      if(widget.url=="") return;

        openRoute(context, 
        ProfileTab(username:widget.appUser)
        );
      },
     
      child: Container(
        constraints:  BoxConstraints(maxHeight: widget.maxsize, maxWidth: widget.maxsize),
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(2),
              margin: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                  color: AppColors.purple,
                  borderRadius: BorderRadius.circular(100)),
              child: Padding(
                padding: const EdgeInsets.all(1),
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(100))),
              ),
            ),
            Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(100)),
                margin: const EdgeInsets.all(10),
                clipBehavior: Clip.hardEdge,
                child:  FittedBox(
                    child:    url()==null ?  Icon( widget.url =="" ? Icons.add:Icons.person, size: 162,):
                SizedBox(
                  width: widget.maxsize,
                  height: widget.maxsize,
                  child: Image.network(
                    fit: BoxFit.fitWidth,
                  url()!
            
                  , 
               
                  // loadingBuilder:(context, child, loadingProgress) => const LinearProgressIndicator(),
                  // frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                  //   return const Text("Frame builder");
                  // },
                  errorBuilder: (context, error, stackTrace) {
                   return  Text(error.toString() + " stack "+  stackTrace.toString(), textAlign: TextAlign.center,) ;
                  },

                  ),
                )
              
                
                )),
            Transform.rotate(
                angle: -3.14 / 6,
                child: Container(
                  constraints: const BoxConstraints.expand(),
                  child: const CircularProgressIndicator(
                    value: 0.65,
                    color: AppColors.yellow,
                    strokeWidth: 2,
                  ),
                )),
          ],
          alignment: Alignment.center,
        ),
      ),
    );
  }
}

class Intrins {}

class SideArrowClip extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();
    final double startMargin = size.width / 2;
    final double s1 = size.height * 0.5;
    final double s2 = size.height * 0.6;
    debugPrint('S1:$s1 SH:${size.height / 2} S2:$s2');
    path.lineTo(startMargin, 0);
    path.lineTo(startMargin, s1);
    path.lineTo(s1, size.height);
    // path.lineTo(0, size.height / 2);
    // path.lineTo(startMargin, s2);
    // path.lineTo(startMargin, size.height);
    // path.lineTo(size.width, size.height);
    // path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
