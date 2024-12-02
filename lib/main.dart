import 'package:allolavage/EntryPoint.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/auth/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  try {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyAvZtYk9qAHqY1tP7r6aIRbS_uyg4Mi5YI",
        appId: "1:939258447963:android:1fa7da7230354430c7177e",
        messagingSenderId: "939258447963",
        projectId: "allolavage-7f82b",
      ),
    );
    print('Firebase initialized successfully');
  } catch (e) {
    print('Firebase initialization error: $e');
  }

  // Initialize timezones
  tz.initializeTimeZones();

  // Check user state
  bool isLoggedIn = await checkUserState();

  runApp(AlloLavageApp(isLoggedIn: isLoggedIn));
}

// Function to check if user exists in SharedPreferences
Future<bool> checkUserState() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? idUser = prefs.getString('idUser');
  return idUser != null && idUser.isNotEmpty;
}

class AlloLavageApp extends StatelessWidget {
  final bool isLoggedIn;

  const AlloLavageApp({Key? key, required this.isLoggedIn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
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
          iconTheme: IconThemeData(color: Colors.white),
        ),
      ),
      home: isLoggedIn ? Entrypoint() : login(),
    );
  }
}
