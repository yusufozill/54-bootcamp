import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'answer_input_box.dart';
class StudyWidget extends StatefulWidget {
  const StudyWidget({Key? key}) : super(key: key);

  @override
  _StudyWidgetState createState() => _StudyWidgetState();
}

class _StudyWidgetState extends State<StudyWidget> {
  TextEditingController controller=TextEditingController();
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return
     Column(
        children: [
          Text(" Çalıştığın alanlardan bahsedebilir misin?",
              style: GoogleFonts.raleway(
                fontSize: 24,
              )),
          const SizedBox(
            height: 50,
          ),
           AnswerInputBox(controller: controller,),
          const SizedBox(
          height: 150,
          ),
         ],
      );

  }
}
