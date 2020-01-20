import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:url_launcher/url_launcher.dart';
import 'StaticsSell.dart';
import 'package:flutter/material.dart';

class StaticsBuy extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _StaticsBuyState();
  }
}

class _StaticsBuyState extends State<StaticsBuy> {
  String datePosted;
  List<StaticsSellersList> staticsBook = List();
  StaticsSellersList book;
  DatabaseReference bookRef;

  @override
  void initState() {
    super.initState();
    book = StaticsSellersList("", "", "");
    final FirebaseDatabase database = FirebaseDatabase
        .instance; //Rather then just writing FirebaseDatabase(), get the instance.
    bookRef = database.reference().child('staticsSellers');
    bookRef.onChildAdded.listen(_onEntryAdded);
    bookRef.onChildChanged.listen(_onEntryChanged);
  }

  _onEntryAdded(Event event) {
    setState(() {
      staticsBook.add(StaticsSellersList.fromSnapshot(event.snapshot));
    });
  }

  _onEntryChanged(Event event) {
    var old = staticsBook.singleWhere((entry) {
      return entry.key == event.snapshot.key;
    });
    setState(() {
      staticsBook[staticsBook.indexOf(old)] =
          StaticsSellersList.fromSnapshot(event.snapshot);
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
                  AspectRatio(
                      aspectRatio: 3 / 2,
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          width: c_width,
                          child: Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(top: 5),
                                    child: Image.asset(
                                      'assets/images/statics.png',
                                      scale: 3.5,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 10),
                                    child: RichText(
                                      text: TextSpan(
                                        style:
                                            DefaultTextStyle.of(context).style,
                                        children: <TextSpan>[
                                          TextSpan(
                                              text:
                                                  'Engineering Mechanics\nStatics & Dynamics\n',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20)),
                                          TextSpan(
                                              text: '13th Edition\n',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18)),
                                          TextSpan(
                                              text: 'R.C.Hibbeler',
                                              style: TextStyle(
                                                  fontStyle: FontStyle.italic,
                                                  fontSize: 18)),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
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
                                'Relevent Courses: ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                      )),
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
                    if (staticsBook[index].datePosted != null) {
                      datePosted = staticsBook[index].datePosted.toString();
                    } else {
                      datePosted = staticsBook[index].datePosted.toString();
                    }
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
                            title: Text('Name: ' + staticsBook[index].userName),
                            subtitle: Text('Contact Info: ' +
                                staticsBook[index].contactInfo),
                          ),
                        ));
                  })),
        ],
      ),
    ));
  }

  _openPDF() async {
    const url =
        'https://openstax.org/details/books/university-physics-volume-1';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _sendPDF() async {
    const url =
        'mailto:?subject=Your Physics Textbook&body=https://openstax.org/details/books/university-physics-volume-1';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
