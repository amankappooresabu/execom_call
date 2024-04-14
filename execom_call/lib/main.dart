import 'package:flutter/material.dart';
import 'package:execom_call/main_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(       
        body: Center(
          child: MyWidget(), // Use MyWidget here
        ),
      ),
    );
  }
}

