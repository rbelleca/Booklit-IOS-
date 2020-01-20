import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class StaticsSell extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _StaticsSellState();
  }
}

class _StaticsSellState extends State<StaticsSell> {
  List<StaticsSellersList> staticsBook = List();
  StaticsSellersList book;
  DatabaseReference bookRef;
  String userPath;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

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

  void handleSubmit() {
    final FormState form = formKey.currentState;

    if (form.validate()) {
      form.save();
      form.reset();
      bookRef.push().set(book.toJson());
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    double c_width = MediaQuery.of(context).size.width;
    // TODO: implement build
    return SafeArea(
      child: Scaffold(
        body: ListView(
          padding: EdgeInsets.all(8),
          children: <Widget>[
            Column(
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
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
                                                  DefaultTextStyle.of(context)
                                                      .style,
                                              children: <TextSpan>[
                                                TextSpan(
                                                    text:
                                                        'Engineering Mechanics\nStatics & Dynamics\n',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 20)),
                                                TextSpan(
                                                    text: '13th Edition\n',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 18)),
                                                TextSpan(
                                                    text: 'R.C.Hibbeler',
                                                    style: TextStyle(
                                                        fontStyle:
                                                            FontStyle.italic,
                                                        fontSize: 18)),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    Text(
                                      'Relevent Courses: ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
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
                          'Sell this book',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.black),
                        )
                      ],
                    )),
                Flexible(
                  flex: 0,
                  child: Center(
                    child: Form(
                      key: formKey,
                      child: Flex(
                        direction: Axis.vertical,
                        children: <Widget>[
                          ListTile(
                            title: TextFormField(
                              initialValue: "",
                              onSaved: (val) => book.userName = val,
                              validator: (val) => val == "" ? val : null,
                              decoration: InputDecoration(
                                  hintText: 'Name',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(50)))),
                            ),
                          ),
                          ListTile(
                            title: TextFormField(
                              initialValue: '',
                              onSaved: (val) => book.contactInfo = val,
                              validator: (val) => val == "" ? val : null,
                              decoration: InputDecoration(
                                  hintText: 'Contact Info (Phone / Email)',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(50)))),
                            ),
                          ),
                          RaisedButton(
                            color: Color.fromRGBO(255, 214, 89, 1),
                            onPressed: handleSubmit,
                            child: Text('Submit'),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class StaticsSellersList {
  String key;
  String userName;
  String contactInfo;
  String datePosted;

  StaticsSellersList(this.userName, this.contactInfo, this.datePosted);

  StaticsSellersList.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        userName = snapshot.value["User Name"],
        contactInfo = snapshot.value["Contact Info"],
        datePosted = snapshot.value["Date posted"];

  toJson() {
    return {
      "User Name": userName,
      "Contact Info": contactInfo,
      "Date Poster": DateTime.now().millisecondsSinceEpoch,
    };
  }
}
