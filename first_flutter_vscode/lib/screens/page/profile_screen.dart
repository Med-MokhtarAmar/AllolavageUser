import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ma Page'),
        backgroundColor: const  Color.fromARGB(220, 35, 102, 195),
        shadowColor: Colors.black,
        elevation: 10,
        titleTextStyle: TextStyle(color: Color(0xF1FFFFFF), fontSize: 18),
        
      ),
      body: Center(child: Text('Ma Page Screen')),
    );
  }
}
