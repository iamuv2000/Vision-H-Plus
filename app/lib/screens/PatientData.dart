import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PatientData extends StatefulWidget {
  PatientData({this.patient});
  var patient;
  @override
  _PatientDataState createState() => _PatientDataState();
}

class _PatientDataState extends State<PatientData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Patient Data'),
      ),
      backgroundColor: Color(0xFF0A0E21),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Card(
                color: Color(0xFF1D1E33).withOpacity(0.8),
                elevation: 3,
                child: Padding(
                  padding:
                      const EdgeInsets.only(top: 50.0, bottom: 50.0, left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Patient Name: ${widget.patient['name']}',
                          style: TextStyle(color: Colors.white, fontSize: 24)),
                      SizedBox(
                        height: 10,
                      ),
                      Text('Age: ${widget.patient['age']}',
                          style: TextStyle(color: Colors.white, fontSize: 20)),
                      SizedBox(
                        height: 10,
                      ),
                      Text('Gender: ${widget.patient['gender']}',
                          style: TextStyle(color: Colors.white, fontSize: 20)),
                    ],
                  ),
                ),
              ),
              Flexible(
                fit: FlexFit.tight,
                child: StreamBuilder<QuerySnapshot>(
                  stream: Firestore.instance
                      .collection('patients')
                      .document(widget.patient['patient_id'])
                      .collection("data")
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError)
                      return new Text('Error: ${snapshot.error}');
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return new Text('Loading...');
                      default:
                        return new ListView(
                          children: snapshot.data.documents
                              .map((DocumentSnapshot doc) {
                            return new Card(
                                color: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 50, top: 30, left: 20, right: 20),
                                  child: Column(
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            "Blood Pressure:",
                                            style: TextStyle(
                                                fontSize: 24,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Text(
                                            doc['bloodpressure'],
                                            style: TextStyle(
                                                fontSize: 24,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Icon(
                                            Icons.local_hospital,
                                            color: Colors.red,
                                            size: 28,
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            "Heart Rate:         ",
                                            style: TextStyle(
                                                fontSize: 24,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Text(
                                            doc['heartrate'],
                                            style: TextStyle(
                                                fontSize: 24,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Icon(
                                            Icons.favorite,
                                            color: Colors.red,
                                            size: 28,
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            "Respiration:       ",
                                            style: TextStyle(
                                                fontSize: 24,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Text(
                                            doc['respiration'],
                                            style: TextStyle(
                                                fontSize: 24,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Icon(
                                            Icons.compare_arrows,
                                            color: Colors.red,
                                            size: 28,
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            "Temperature:     ",
                                            style: TextStyle(
                                                fontSize: 24,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Text(
                                            doc['temperature'],
                                            style: TextStyle(
                                                fontSize: 24,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Icon(
                                            Icons.gradient,
                                            color: Colors.red,
                                            size: 28,
                                          )
                                        ],
                                      ),
                                    ],
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                  ),
                                ));
                          }).toList(),
                        );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
