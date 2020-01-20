import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:url_launcher/url_launcher.dart';
import 'PhysicsSell.dart';
import 'package:flutter/material.dart';

class PhysicsBuy extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _PhysicsBuyState();
  }
}

class _PhysicsBuyState extends State<PhysicsBuy> {
  List<PhysicsSellersList> physicsBook = List();
  PhysicsSellersList book;
  DatabaseReference bookRef;

  @override
  void initState() {
    super.initState();
    book = PhysicsSellersList("", "");
    final FirebaseDatabase database = FirebaseDatabase
        .instance; //Rather then just writing FirebaseDatabase(), get the instance.
    bookRef = database.reference().child('physicsSellers');
    bookRef.onChildAdded.listen(_onEntryAdded);
    bookRef.onChildChanged.listen(_onEntryChanged);
  }

  _onEntryAdded(Event event) {
    setState(() {
      physicsBook.add(PhysicsSellersList.fromSnapshot(event.snapshot));
    });
  }

  _onEntryChanged(Event event) {
    var old = physicsBook.singleWhere((entry) {
      return entry.key == event.snapshot.key;
    });
    setState(() {
      physicsBook[physicsBook.indexOf(old)] =
          PhysicsSellersList.fromSnapshot(event.snapshot);
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
                                      'assets/images/physics.png',
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
                                                  'University Physics\nwith Modern\nPhysics\n',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20)),
                                          TextSpan(
                                              text: '13th Edition\n',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18)),
                                          TextSpan(
                                              text: 'Young & Freedman',
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
                                'Relevent Courses: Physics 2100, Physics 2200',
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
                            title: Text('Name: ' + physicsBook[index].userName),
                            subtitle: Text('Contact Info: ' +
                                physicsBook[index].contactInfo),
                          ),
                        ));
                  })),
        ],
      ),
    ));
  }

  _openPDF() async {
    const url =
        'https://openstax.org/books/university-physics-volume-1/pages/1-introduction';
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
