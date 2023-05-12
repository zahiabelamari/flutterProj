import 'package:flutter/material.dart';
import 'package:untitledfilms/AddFilm.dart';
import 'package:untitledfilms/Home.dart';


void main()=>runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Films',
      home: Home(),
      routes: {
        "addfilm":(context)=>AddFilm()
      },
    );
  }
}
