import 'package:flutter/material.dart';
import 'package:tablas_de_multiplicar/const/const.dart';
import 'package:tablas_de_multiplicar/screens/table/game_screen.dart';

class NumberScreen extends StatefulWidget {
  final int number;

  NumberScreen(this.number);

  @override
  _NumberScreenState createState() => _NumberScreenState();
}

class _NumberScreenState extends State<NumberScreen> {
  int number;
  List<String> table;

  Size _size;

  @override
  void initState() {
    this.number = widget.number;
    this.table = calc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kBodyColor,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _title(),
              ...table.map((t) => _text(t)),
              _menu(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _menu(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buttonMenu("Jugar", () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => GameScreen(number),
                ));
              }),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buttonMenu(String text, Function f) {
    return GestureDetector(
      onTap: f,
      child: Container(
        height: 60.0,
        width: 120.0,
        decoration: BoxDecoration(
            color: Color(0xFFf5a31a),
            borderRadius: BorderRadius.circular(10.0)),
        child: Center(
          child: Text(text,
              style: TextStyle(
                color: Colors.white,
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              )),
        ),
      ),
    );
  }

  Widget _title() {
    return Container(
      margin: EdgeInsets.only(
        bottom: 10.0,
      ),
      child: Text(
        "Tablas de multiplicar del $number",
        style: TextStyle(
          fontSize: 20.0,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _text(String text) {
    return Container(
      width: _size.width * 0.4,
      margin: EdgeInsets.all(5.0),
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: Colors.green.shade400,
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  List<String> calc() {
    List<String> res = [];
    for (var i = 1; i <= 10; i++) {
      res.add("$number x $i = ${number * i}");
    }
    return res;
  }
}
