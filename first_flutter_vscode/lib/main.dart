import 'package:flutter/material.dart';
import 'screens/welcome_screen.dart';

void main() {
  runApp(AlloLavageApp());
}

class AlloLavageApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Cache le bandeau "Debug"
      title: 'Allo Lavage',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WelcomeScreen(),
    );
  }
}
