import 'package:antello/classes/new_user_informations.dart';
import 'package:antello/widgets/photo_chart.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PPUpload extends StatefulWidget {
  final String username;
  const PPUpload({ Key? key, required this.username }) : super(key: key);

  @override
  State<PPUpload> createState() => _PPUploadState();
}

class _PPUploadState extends State<PPUpload> {
  String filePath="";
  String image="";

   XFile? xFile;
     Future<String>getImage() async {
      String uint8list = await FirebaseStorage.instance.ref(filePath).getDownloadURL();   
      return uint8list;

  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
    
        
      
        PhotoChart(
          maxsize: 200,
          url: image, fun: ()
     async{
          print("object");
            xFile= await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 25);
            if (xFile ==null) return ;
            final finalPath =     FirebaseStorage.instance.ref('photos').child(widget.username+".jpg");
            await finalPath.putData(await xFile!.readAsBytes());
            filePath=finalPath.fullPath;
            
            var mmm= await getImage();
              setState(() {
        print(mmm) ;                                   
        image=mmm;

        if(image!=null&& image!=""){
        NewUser.url=image;

        }
        


              }); 
         }
     
          
        ,),


     ]
    );
  }
}