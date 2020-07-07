import 'package:flutter/material.dart';
import 'package:tablas_de_multiplicar/screens/home/home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tablas de Multiplicar',
      home: HomeScreen(),
    );
  }
}
