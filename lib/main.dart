import 'package:flutter/material.dart';
import 'package:my_app/qr_scan_page.dart';

void main() {
 
  runApp(StudentBusPassApp());
}

class StudentBusPassApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Student Bus Pass',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}
