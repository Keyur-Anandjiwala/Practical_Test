import 'package:flutter/material.dart';
import 'package:practical_test/country_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Practical Test',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CountryList(),
    );
  }
}
