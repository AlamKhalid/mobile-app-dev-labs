import 'dart:async';
import 'package:flutter/material.dart';
import 'loginScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Splash Screen',
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 2),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return  Container(
   color: Colors.grey[100],
          child:    CircleAvatar(
               radius: 10,
               backgroundColor: Colors.deepPurple,
                child: Container(
                    child: CircleAvatar(radius: 100,
                    backgroundColor: Colors.black54,
                backgroundImage: AssetImage(
                    "logo.png",
                  ),
                ))),);
  }
}
