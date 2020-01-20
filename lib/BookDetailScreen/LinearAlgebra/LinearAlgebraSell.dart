import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class LinearAlgebraSell extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _LinearAlgebraSellState();
  }
}

class _LinearAlgebraSellState extends State<LinearAlgebraSell> {
  List<LinearSellersList> linearBook = List();
  LinearSellersList book;
  DatabaseReference bookRef;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    book = LinearSellersList("", "");
    final FirebaseDatabase database = FirebaseDatabase
        .instance; //Rather then just writing FirebaseDatabase(), get the instance.
    bookRef = database.reference().child('linearSellers');
    bookRef.onChildAdded.listen(_onEntryAdded);
    bookRef.onChildChanged.listen(_onEntryChanged);
  }

  _onEntryAdded(Event event) {
    setState(() {
      linearBook.add(LinearSellersList.fromSnapshot(event.snapshot));
    });
  }

  _onEntryChanged(Event event) {
    var old = linearBook.singleWhere((entry) {
      return entry.key == event.snapshot.key;
    });
    setState(() {
      linearBook[linearBook.indexOf(old)] =
          LinearSellersList.fromSnapshot(event.snapshot);
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
                                            'assets/images/linear_algebra.jpg',
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
                                                        'Introduction to\nLinear Algebra\n',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 20)),
                                                TextSpan(
                                                    text: '5th Edition\n',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 18)),
                                                TextSpan(
                                                    text: 'Gilbert Strang',
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
                                      'Relevent Courses: Math 2550',
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

class LinearSellersList {
  String key;
  String userName;
  String contactInfo;

  LinearSellersList(this.userName, this.contactInfo);

  LinearSellersList.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        userName = snapshot.value["User Name"],
        contactInfo = snapshot.value["Contact Info"];

  toJson() {
    return {
      "User Name": userName,
      "Contact Info": contactInfo,
    };
  }
}
