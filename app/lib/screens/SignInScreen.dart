import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'HomeScreen.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _auth = FirebaseAuth.instance;
  String email;
  String error = "";
  String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Vision H+",
                style: TextStyle(
                    fontSize: 42,
                    color: Colors.white,
                    fontFamily: "RobotoMono",
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 20),
              Text(
                "Log in",
                style: TextStyle(
                    fontSize: 34,
                    color: Colors.white,
                    fontFamily: "RobotoMono",
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(height: 20),
              TextFormField(
                style: TextStyle(color: Colors.white, fontSize: 22),
                decoration: InputDecoration(
                  labelText: 'Enter ID',
                  labelStyle: TextStyle(color: Colors.white, fontSize: 24),
                  filled: true,
                  fillColor: Colors.white10,
                  focusColor: Colors.white,
                  hoverColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: Colors.blue,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: Colors.redAccent,
                      width: 1.2,
                    ),
                  ),
                ),
                onChanged: (value) {
                  email = value;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                style: TextStyle(color: Colors.white, fontSize: 22),
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(color: Colors.white, fontSize: 24),
                  filled: true,
                  fillColor: Colors.white10,
                  focusColor: Colors.white,
                  hoverColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: Colors.blue,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: Colors.redAccent,
                      width: 1.2,
                    ),
                  ),
                ),
                onChanged: (value) {
                  password = value;
                },
              ),
              SizedBox(height: 20),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 22),
              ),
              Container(
                  child: RaisedButton(
                    onPressed: () async {
                      print("Log in button pressed!");
                      try {
                        final newUser = await _auth.signInWithEmailAndPassword(
                            email: email.trim(), password: password);
                        if (newUser != null) {
                          setState(() {
                            error = "";
                          });
                          print("User has been logged in");
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return HomeScreen();
                          }));
                        }
                      } catch (e) {
                        print(e.message);
                        setState(() {
                          error = e.message;
                        });
                      }
                    },
                    color: Colors.red,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.red)),
                    child: Center(
                      child: Text(
                        'Log in',
                        style: TextStyle(
                            fontSize: 25.0,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87),
                      ),
                    ),
                  ),
                  margin: EdgeInsets.only(top: 10.0),
                  width: double.infinity,
                  height: 70.0)
            ],
          ),
        ),
      ),
    );
  }
}
