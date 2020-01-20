import 'package:booklit/Auth/sign_in.dart';
import 'package:booklit/Screens/AccountRelated/UserProfile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Account extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AccountState();
  }
}

class _AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: Scaffold(
        body: ListView(
          padding: EdgeInsets.all(8),
          children: <Widget>[
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                'BookLit',
                style: TextStyle(
                    color: Color.fromRGBO(255, 214, 89, 1),
                    fontSize: 40,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Card(
                      color: Color.fromRGBO(255, 236, 179, 1),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          ListTile(
                            leading: Icon(
                              Icons.account_circle,
                              size: 50,
                              color: Colors.black,
                            ),
                            title: FutureBuilder(
                              future: FirebaseAuth.instance.currentUser(),
                              builder: (context,
                                  AsyncSnapshot<FirebaseUser> snapshot) {
                                if (snapshot.hasData) {
                                  String email = snapshot.data.email;
                                  String userName = email.substring(
                                      0, email.indexOf("@calstatela.edu"));
                                  return Text(
                                    'User Name: ' + userName,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 15),
                                  );
                                } else {
                                  return Text('Loading...');
                                }
                              },
                            ),
                            subtitle: FutureBuilder(
                              future: FirebaseAuth.instance.currentUser(),
                              builder: (context,
                                  AsyncSnapshot<FirebaseUser> snapshot) {
                                if (snapshot.hasData) {
                                  String email = snapshot.data.email;
                                  return Text(
                                    'Email: ' + email,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 15),
                                  );
                                } else {
                                  return Text('Loading...');
                                }
                              },
                            ),
                            trailing: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            UserProfile()));
                              },
                              child: Icon(Icons.edit),
                            ),
                          )
                        ],
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
