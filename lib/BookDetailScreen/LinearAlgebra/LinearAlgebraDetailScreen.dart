import 'package:flutter/material.dart';
import 'LinearAlgebraBuy.dart';
import 'LinearAlgebraSell.dart';

class LinearAlgebraDetailScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _LinearAlgebraDetailState();
  }
}

class _LinearAlgebraDetailState extends State<LinearAlgebraDetailScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: Scaffold(
          body: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            bottom: TabBar(
              tabs: [
                Tab(
                  text: "Buy",
                ),
                Tab(text: "Sell"),
              ],
            ),
            title: Text(
              'BookLit',
              style: TextStyle(
                  color: Color.fromRGBO(255, 214, 89, 1),
                  fontSize: 40,
                  fontWeight: FontWeight.bold),
            ),
          ),
          body: TabBarView(
            children: [LinearAlgebraBuy(), LinearAlgebraSell()],
          ),
        ),
      )),
    );
  }
}
