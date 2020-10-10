import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _fireStore = Firestore.instance;
FirebaseUser loggedInUser;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _auth = FirebaseAuth.instance;
  String search = '';

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.blue, //or set color with: Color(0xFF0000FF)
    ));
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.red,
      appBar: AppBar(
        elevation: 4.0,
        title: Text(
          "Patient View",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.red,
      ),
      body: SafeArea(
        child: Container(
          color: Colors.black,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Hello, Dr Singh",
                    style: TextStyle(color: Colors.white, fontSize: 28),
                  ),
                ),
                TextFormField(
                  style: TextStyle(color: Colors.black, fontSize: 22),
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: 'Search Patient...',
                    labelStyle: TextStyle(color: Colors.black, fontSize: 20),
                    filled: true,
                    fillColor: Colors.white,
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
                        width: 1,
                      ),
                    ),
                  ),
                  onChanged: (value) {
                    search = value;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                    child: StreamBuilder<QuerySnapshot>(
                        stream: _fireStore
                            .collection('patients')
                            .where('doctor_id', isEqualTo: "abc")
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (!snapshot.hasData)
                            return new Text('Loading...',
                                style: TextStyle(color: Colors.white));
                          return ListView.builder(
                              itemCount: snapshot.data.documents.length,
                              itemBuilder: (BuildContext context, int index) {
                                //sort my data by timestamp before building
                                return Card(
                                  child: InkWell(
                                    splashColor:
                                        Colors.blueAccent.withAlpha(30),
                                    onTap: () {
                                      print('Card tapped.');
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Container(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 10, bottom: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text(
                                                snapshot.data.documents[index]
                                                    ['name'],
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 24),
                                              ),
                                              Text(
                                                "Age: ${snapshot.data.documents[index]['age']}",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 20),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              });
                        }))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
