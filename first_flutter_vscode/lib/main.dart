import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'screens/login.dart';

void main() {
  runApp(AlloLavageApp());
}

class AlloLavageApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false, // Cache le bandeau "Debug"
      title: 'Allo Lavage',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blueAccent, 
          shadowColor: Color.fromARGB(255, 0, 0, 0),
          elevation: 10, 
          titleTextStyle: TextStyle(
            color: Colors.white, 
            fontSize: 17, 
            fontWeight: FontWeight.bold, 
          ),
          iconTheme: IconThemeData(
            color: Colors.white, 
          ),
        ),
      ),
      home: login(),
    );
  }
}
