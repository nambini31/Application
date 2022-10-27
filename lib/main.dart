// ignore_for_file: prefer_const_constructors,, use_key_in_widget_constructors

import 'package:app/Ecran/Pages/HomeApplication.dart';
import "package:flutter/material.dart";

void main(List<String> args) {
  runApp(Application());
}

class Application extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeApplication(),
      debugShowCheckedModeBanner: false,
    );
  }
}
