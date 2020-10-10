import 'package:flutter/material.dart';
import './screens/HomeScreen.dart';

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
                child: HomeScreen()),
          ),
        ),
      ),
    );
  }
}
