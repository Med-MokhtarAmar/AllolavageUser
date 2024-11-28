import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'screens/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
void main() async {
  // final SharedPreferences pref = await SharedPreferences.getInstance();
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyAvZtYk9qAHqY1tP7r6aIRbS_uyg4Mi5YI",
            appId: "1:939258447963:android:1fa7da7230354430c7177e",
            messagingSenderId: "939258447963",
            projectId: "allolavage-7f82b"));
    print('Firebase initialized successfully');
  } catch (e) {
    print('Firebase initialization error: $e');
  }
  tz.initializeTimeZones();  // Initialize timezones package
  
  // Set the timezone to your local timezone, e.g., Africa/Nouakchott
  final mylocation = tz.getLocation('Africa/Nouakchott');

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
