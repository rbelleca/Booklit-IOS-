import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import './DatabaseSell.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:url_launcher/url_launcher.dart';

class DatabaseBuy extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _DatabaseBuyState();
  }
}

class _DatabaseBuyState extends State<DatabaseBuy> {
  List<DatabaseSellersList> databaseBook = List();
  DatabaseSellersList book;
  DatabaseReference bookRef;

  @override
  void initState() {
    super.initState();
    book = DatabaseSellersList("", "");
    final FirebaseDatabase database = FirebaseDatabase
        .instance; //Rather then just writing FirebaseDatabase(), get the instance.
    bookRef = database.reference().child('databasesellers');
    bookRef.onChildAdded.listen(_onEntryAdded);
    bookRef.onChildChanged.listen(_onEntryChanged);
  }

  _onEntryAdded(Event event) {
    setState(() {
      databaseBook.add(DatabaseSellersList.fromSnapshot(event.snapshot));
    });
  }

  _onEntryChanged(Event event) {
    var old = databaseBook.singleWhere((entry) {
      return entry.key == event.snapshot.key;
    });
    setState(() {
      databaseBook[databaseBook.indexOf(old)] =
          DatabaseSellersList.fromSnapshot(event.snapshot);
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    double c_width = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: <Widget>[
          Flexible(
              flex: 0,
              child: Column(
                children: <Widget>[
                  Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        width: c_width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(top: 5),
                              child: Image.asset(
                                'assets/images/database.png',
                                scale: 3,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: RichText(
                                text: TextSpan(
                                  style: DefaultTextStyle.of(context).style,
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: 'Database System\nConcepts\n',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20)),
                                    TextSpan(
                                        text: '6th Edition\n',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18)),
                                    TextSpan(
                                        text:
                                            'Abraham Silberschatz\nHenry F. Korth\nS. Sudarshan',
                                        style: TextStyle(
                                            fontStyle: FontStyle.italic)),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      )),
                  ButtonBar(
                    alignment: MainAxisAlignment.center,
                    children: <Widget>[
                      RaisedButton(
                        elevation: 5,
                        onPressed: _openPDF,
                        color: Color.fromRGBO(255, 204, 0, 1),
                        child: Text('Open PDF'),
                      ),
                      RaisedButton(
                        elevation: 5,
                        onPressed: _sendPDF,
                        color: Color.fromRGBO(255, 204, 0, 1),
                        child: Text('Send PDF'),
                      ),
                    ],
                  ),
                  Text(
                    'Relevent Courses:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Text(
                    'CS 1222',
                    style: TextStyle(fontSize: 18),
                  ),
                  Divider(
                    color: Colors.black,
                    thickness: .5,
                  ),
                  Text(
                    'On-Campus Sellers',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.black),
                  )
                ],
              )),
          Flexible(
              child: FirebaseAnimatedList(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  query: bookRef,
                  itemBuilder: (BuildContext context, DataSnapshot snapshot,
                      Animation<double> animation, int index) {
                    return new Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: Card(
                          color: Color.fromRGBO(255, 236, 179, 1),
                          child: ListTile(
                            leading: Icon(
                              Icons.account_circle,
                              color: Colors.black,
                              size: 50,
                            ),
                            title:
                                Text('Name: ' + databaseBook[index].userName),
                            subtitle: Text('Contact Info: ' +
                                databaseBook[index].contactInfo),
                          ),
                        ));
                  })),
        ],
      ),
    ));
  }
}

_openPDF() async {
  const url =
      'https://kakeboksen.td.org.uit.no/Database%20System%20Concepts%206th%20edition.pdf';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

_sendPDF() async {
  const url =
      'mailto:?subject=Your Database Textbook&body=https://kakeboksen.td.org.uit.no/Database%20System%20Concepts%206th%20edition.pdf';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
