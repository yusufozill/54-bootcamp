
import 'package:antello/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DateTimePicker extends StatelessWidget{
  final DateTime date;
  final Function(DateTime) function;

  const DateTimePicker({Key? key, required this.date,required this.function}): super(key: key);

  @override
  Widget build(BuildContext context) {
    String text(){
      if(    DateTime.now().difference(date) >const Duration(days: 365*18)){
        return "${date.day.toString()}/${date.month.toString()}/${date.year.toString()}";
      } else {
        return "Doğum gününüzü seçiniz";
      }
    }
    return Column(children: [
      ElevatedButton(
          style: ElevatedButton.styleFrom(
            fixedSize:const Size(300,50),
            primary: Colors.white,
            shadowColor: Colors.grey,
            elevation: 6,
          ),
          child: Text(text(),
              style: GoogleFonts.raleway(
                fontSize: 16,
                color: AppColors.purple,
              )),
          onPressed: () async {
            DateTime? newDate = await showDatePicker(
              context: context,
              initialDate: date,
              firstDate: DateTime(1920),
              lastDate: DateTime.now(),
            );
          

            if (newDate == null
            /// TO DO: buraya 18 yaş condition ekle ||DateTime.now().difference(newDate).inDays < 365*18
               ) {
              return;
            } else {
            
                 function(newDate);
          
            }
          }),
    ]);
  }
}
