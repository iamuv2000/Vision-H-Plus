import 'package:flutter/material.dart';
import 'package:vision_h_plus/screens/SignInScreen.dart';
import './screens/SignInScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "VisionH+",
      home: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          backgroundColor: Colors.black,
          body: SafeArea(
            child: Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: SignInScreen()),
          ),
        ),
      ),
    );
  }
}
