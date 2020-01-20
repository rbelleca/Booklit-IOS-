import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import './JavaSell.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:url_launcher/url_launcher.dart';

class JavaBuy extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _JavaBuyState();
  }
}

class _JavaBuyState extends State<JavaBuy> {
  List<JavaSellList> javaBook = List();
  JavaSellList book;
  DatabaseReference bookRef;

  @override
  void initState() {
    super.initState();
    book = JavaSellList("", "");
    final FirebaseDatabase database = FirebaseDatabase
        .instance; //Rather then just writing FirebaseDatabase(), get the instance.
    bookRef = database.reference().child('javasellers');
    bookRef.onChildAdded.listen(_onEntryAdded);
    bookRef.onChildChanged.listen(_onEntryChanged);
  }

  _onEntryAdded(Event event) {
    setState(() {
      javaBook.add(JavaSellList.fromSnapshot(event.snapshot));
    });
  }

  _onEntryChanged(Event event) {
    var old = javaBook.singleWhere((entry) {
      return entry.key == event.snapshot.key;
    });
    setState(() {
      javaBook[javaBook.indexOf(old)] =
          JavaSellList.fromSnapshot(event.snapshot);
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 5, left: 20),
                          child: Image.asset(
                            'assets/images/java_10.png',
                            width: 100,
                            scale: 2.5,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: RichText(
                            text: TextSpan(
                              style: DefaultTextStyle.of(context).style,
                              children: <TextSpan>[
                                TextSpan(
                                    text: 'Intro to Java\nProgramming\n',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20)),
                                TextSpan(
                                    text: '10th Edition\n',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18)),
                                TextSpan(
                                    text: 'Daniel Liang',
                                    style:
                                        TextStyle(fontStyle: FontStyle.italic)),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
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
                    'CS 2011, CS 2012, CS 2013',
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
                            title: Text('Name: ' + javaBook[index].userName),
                            subtitle: Text(
                                'Contact Info: ' + javaBook[index].contactInfo),
                          ),
                        ));
                  })),
        ],
      ),
    ));
  }

  _openPDF() async {
    const url =
        'http://www.primeuniversity.edu.bd/160517/vc/eBook/download/IntroductiontoJava.pdf';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _sendPDF() async {
    const url =
        'mailto:?subject=Your Java Textbook&body=http://www.primeuniversity.edu.bd/160517/vc/eBook/download/IntroductiontoJava.pdf';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
