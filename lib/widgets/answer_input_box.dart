import 'package:antello/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../classes/new_user_informations.dart';

class AnswerInputBox extends StatefulWidget {
  final TextEditingController controller;

  const AnswerInputBox({Key? key, required this.controller}) : super(key: key);

  @override
  _AnswerInputBoxState createState() => _AnswerInputBoxState();
}

class _AnswerInputBoxState extends State<AnswerInputBox> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() => setState(() {
          NewUser.department = widget.controller.text;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 320,
      height: 50,
      child: TextField(
        controller: widget.controller,
        maxLength: 20,
        decoration: InputDecoration(
          icon: const Icon(FontAwesomeIcons.book),
          hintText: "matematik,biyoloji.....",
          hintStyle: const TextStyle(
            color: AppColors.purple,
            fontStyle: FontStyle.italic,
          ),
          suffixIcon: widget.controller.text.isEmpty
              ? Container(
                  width: 0,
                )
              : IconButton(
                  onPressed: () => widget.controller.clear(),
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
