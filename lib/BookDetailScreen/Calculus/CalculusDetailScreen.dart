import 'package:flutter/material.dart';
import 'CaclulusBuy.dart';
import 'CalculusSell.dart';

class CalculusDetailScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CalculusDetailState();
  }
}

class _CalculusDetailState extends State<CalculusDetailScreen> {
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
            children: [CalculusBuy(), CalculusSell()],
          ),
        ),
      )),
    );
  }
}
