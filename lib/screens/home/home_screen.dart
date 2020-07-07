import 'package:flutter/material.dart';
import 'package:tablas_de_multiplicar/screens/table/number_screen.dart';

class HomeScreen extends StatelessWidget {
  BuildContext globalContext;
  Size size;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    this.globalContext = context;
    return Scaffold(
      backgroundColor: Colors.green,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            _title(),
            SizedBox(height: 15.0),
            _row(1, 2),
            _row(3, 4),
            _row(5, 6),
            _row(7, 8),
            _row(9, 10),
          ],
        ),
      ),
    );
  }

  Widget _row(int n1, int n2) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 11.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _button(n1),
          _button(n2),
        ],
      ),
    );
  }

  Widget _button(int number) {
    return GestureDetector(
      onTap: () {
        Navigator.of(globalContext).push(
          MaterialPageRoute(
              builder: (BuildContext context) => NumberScreen(number)),
        );
      },
      child: Container(
        width: 100.0,
        height: size.height * 0.12,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: Colors.green.shade400,
        ),
        child: Center(
          child: Text(
            "$number",
            style: TextStyle(
              color: Colors.white,
              fontSize: 35.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _title() {
    return Container(
      padding: EdgeInsets.only(top: 14.0),
      width: double.infinity,
      child: Text(
        "Tablas de multiplicar",
        style: TextStyle(
          color: Colors.white,
          fontSize: 34.0,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
