import 'package:booklit/BookDetailScreen/Calculus/CalculusDetailScreen.dart';
import 'package:booklit/BookDetailScreen/Database/DatabaseDetailScreen.dart';
import 'package:booklit/BookDetailScreen/Java/JavaDetailScreen.dart';
import 'package:booklit/BookDetailScreen/LinearAlgebra/LinearAlgebraDetailScreen.dart';
import 'package:booklit/BookDetailScreen/Physics/PhysicsDetailScreen.dart';
import 'package:booklit/BookDetailScreen/Statics/SaticsDetailScreen.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: Scaffold(
          body: ListView(
        padding: EdgeInsets.all(8),
        children: <Widget>[
          //App name
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
          //CS related
          Padding(
            padding: EdgeInsets.only(top: 20),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                'CS Top Picks',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 20.0),
            height: 200.0,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => JavaDetailScreen()),
                    );
                  },
                  child: Card(
                    child: Image.asset('assets/images/java_10.png'),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DatabaseDetailScreen()),
                    );
                  },
                  child: Card(
                    child: Image.asset('assets/images/database.png'),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CalculusDetailScreen()),
                    );
                  },
                  child: Card(
                    child: Image.asset('assets/images/calculus.jpg'),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LinearAlgebraDetailScreen()),
                    );
                  },
                  child: Card(
                    child: Image.asset('assets/images/linear_algebra.jpg'),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PhysicsDetailScreen()),
                    );
                  },
                  child: Card(
                    child: Image.asset('assets/images/physics.png'),
                  ),
                )
              ],
            ),
          ),
          Divider(
            color: Colors.black,
            thickness: .5,
          ),
          //Engineering
          Padding(
            padding: EdgeInsets.only(top: 20),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Engineering Top Picks',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 20.0),
            height: 200.0,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => StaticsDetailScreen()),
                    );
                  },
                  child: Card(
                    child: Image.asset('assets/images/statics.png'),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CalculusDetailScreen()),
                    );
                  },
                  child: Card(
                    child: Image.asset('assets/images/calculus.jpg'),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LinearAlgebraDetailScreen()),
                    );
                  },
                  child: Card(
                    child: Image.asset('assets/images/linear_algebra.jpg'),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PhysicsDetailScreen()),
                    );
                  },
                  child: Card(
                    child: Image.asset('assets/images/physics.png'),
                  ),
                )
              ],
            ),
          ),
          Divider(
            color: Colors.black,
            thickness: .5,
          ),
        ],
      )),
    );
  }
}
