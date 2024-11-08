import 'package:flutter/material.dart';
import 'create_account_screen.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final titleStyle = TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
    );

    final disclaimerStyle = TextStyle(
      fontSize: 12,
      color: Color.fromARGB(255, 138, 138, 139),
    );

    return Scaffold(
      backgroundColor: Colors.white, // Couleur de fond de la page
      appBar: AppBar(
        backgroundColor: Color.fromARGB(220, 35, 102, 195),
        shadowColor: Color.fromARGB(255, 0, 0, 0),
        elevation: 10,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'images/logo.png',
              height: 150, // Ajustez la taille selon vos besoins
              width: 150,
              fit: BoxFit.cover,
              
            ),
            SizedBox(height: 1),
            Center(
              child: Text(
                'Bienvenue !',
                style: titleStyle,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 2),
            Center(
              child: Text(
                'En vous inscrivant sur Allo Lavage, vous acceptez la Politique de Confidentialité !',
                style: disclaimerStyle,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CreateAccountScreen()),
                );
              },
              child: Text('Créer un compte'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(220, 35, 102, 195),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 70, vertical: 18),
                textStyle: TextStyle(fontSize: 16),
                shadowColor: Colors.black,
                elevation: 15,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
