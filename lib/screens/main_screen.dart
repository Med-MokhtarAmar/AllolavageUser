import 'package:flutter/material.dart';
import 'home/home_screen.dart';
import 'voiture/car_screen.dart';
import 'demande/reservation_screen.dart';
import 'page/profile_screen.dart';


class MainScreen extends StatefulWidget {
 

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  List<Widget> _pages = <Widget>[
    HomeScreen(),
    CarScreen(),
    ReservationScreen(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: const Color.fromARGB(220, 35, 102, 195), 
        ),
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.directions_car),
              label: 'Voiture',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today),
              label: 'Demande',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Page',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: const Color.fromARGB(255, 239, 185, 252), // Color of the selected text
          unselectedItemColor: Colors.white, // Color of the unselected text
          showUnselectedLabels: true, // Show unselected labels
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
