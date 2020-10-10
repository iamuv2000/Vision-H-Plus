import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PatientData extends StatefulWidget {
  @override
  _PatientDataState createState() => _PatientDataState();
}

class _PatientDataState extends State<PatientData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection('data').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return new Text('Loading...');
            default:
              return new ListView(
                children: snapshot.data.documents.map((DocumentSnapshot doc) {
                  return new Card(
                      color: Colors.white,
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 30.0,
                            child: ListTile(
                              title: Text(
                                "BloodPressure:${doc['bloodpressure']}",
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          SizedBox(
                            height: 30.0,
                            child: ListTile(
                              title: Text(
                                "Heart Rate:${doc['heartrate']}",
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30.0,
                            child: ListTile(
                              title: Text(
                                "Respiration:${doc['respiration']}",
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30.0,
                            child: ListTile(
                              title: Text(
                                "Temperature:${doc['temperature']}",
                              ),
                            ),
                          ),
                        ],
                        crossAxisAlignment: CrossAxisAlignment.start,
                      ));
                }).toList(),
              );
          }
        },
      ),
    );
  }
}
