import 'package:flutter/material.dart';

openRoute(BuildContext context, Widget route){

                   Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => route
          ),
        );
}