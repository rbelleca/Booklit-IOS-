/*
Not required for version 1.0
 */
import 'package:booklit/Auth/Login.dart';
import 'package:booklit/Auth/sign_in.dart';
import 'package:booklit/Navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'SignUp.dart';

class AuthMenu extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AuthMenuState();
  }
}

class _AuthMenuState extends State<AuthMenu> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/loginbackground.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
              child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'BookLit',
                  style: TextStyle(
                      fontSize: 40,
                      color: Color.fromRGBO(255, 204, 0, 1),
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  'For Students By Students',
                  style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontSize: 20,
                      color: Colors.white),
                ),
                Text(
                  'Choose a Login Method',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                SignInButton(
                  Buttons.Email,
                  text: 'Login with Email',
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return Login();
                        },
                      ),
                    );
                  },
                ),
                SignInButton(
                  Buttons.Google,
                  text: 'Login with Google',
                  onPressed: () {
                    signInWithGoogle().whenComplete(() {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return Navigation();
                          },
                        ),
                      );
                    });
                  },
                ),
//                SignInButton(
//                  Buttons.Facebook,
//                  text: 'Login with Facebook',
//                  onPressed: () {},
//                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: new Container(
                          margin:
                              const EdgeInsets.only(left: 10.0, right: 20.0),
                          child: Divider(
                            color: Colors.black,
                            height: 36,
                          )),
                    ),
                    Text(
                      "OR",
                      style: TextStyle(color: Colors.black),
                    ),
                    Expanded(
                      child: new Container(
                          margin:
                              const EdgeInsets.only(left: 20.0, right: 10.0),
                          child: Divider(
                            color: Colors.black,
                            height: 36,
                          )),
                    ),
                  ],
                ),
                SignInButton(Buttons.Email, text: 'Create an Account',
                    onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return SignUp();
                      },
                    ),
                  );
                })
              ],
            ),
          )),
        ),
      ),
    );
  }
}
