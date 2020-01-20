import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class JavaSell extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _JavaSellState();
  }
}

class _JavaSellState extends State<JavaSell> {
  List<JavaSellList> javaBook = List();
  JavaSellList book;
  DatabaseReference bookRef;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

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
                                          style: TextStyle(
                                              fontStyle: FontStyle.italic)),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Text(
                          'Relevent Courses:',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
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

class JavaSellList {
  String key;
  String userName;
  String contactInfo;

  JavaSellList(this.userName, this.contactInfo);

  JavaSellList.fromSnapshot(DataSnapshot snapshot)
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
