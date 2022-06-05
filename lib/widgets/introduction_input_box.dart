import 'package:antello/classes/new_user_informations.dart';
import 'package:antello/themes/app_colors.dart';
import 'package:flutter/material.dart';

class IntroductionInputBox extends StatefulWidget {
  const IntroductionInputBox({Key? key}) : super(key: key);

  @override
  _IntroductionInputBoxState createState() => _IntroductionInputBoxState();
}

class _IntroductionInputBoxState extends State<IntroductionInputBox> {
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() => setState(() {
      NewUser.bio=_controller.text;
    }));
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 320,
      height: 200,

      child: TextFormField(
  
        controller: _controller,
        maxLines: 20,
        maxLength: 300,
        keyboardType: TextInputType.multiline,
        decoration: InputDecoration(
          icon: const Icon(Icons.account_circle_rounded),
          hintText: "Biraz kendinizden bahseder misiniz...",
          hintStyle: const TextStyle(
            color: AppColors.purple,
            fontStyle: FontStyle.italic,
          ),
          suffixIcon: _controller.text.isEmpty
              ? Container(
            width: 0,
          )
              : IconButton(
              onPressed: () => _controller.clear(),
              icon: const Icon(Icons.close)),
          border: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        textInputAction: TextInputAction.continueAction,
      ),
    );
  }
}