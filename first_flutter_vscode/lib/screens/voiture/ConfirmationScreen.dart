import 'package:flutter/material.dart';
import 'wash_screen.dart';

class ConfirmationScreen extends StatelessWidget {
  final String carName;        // Car Name
  final String carSize;        // Car Size
  final String registration;    // Registration Number
  final String bookingTime;     // Booking Date and Time

  const ConfirmationScreen({
    Key? key,
    required this.carName,
    required this.carSize,
    required this.registration,
    required this.bookingTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Confirmation de Lavage',
          style: TextStyle(color: Colors.white, fontSize: 17),
        ),
        backgroundColor: const Color.fromARGB(220, 35, 102, 195),
        shadowColor: Colors.black,
        elevation: 10,
        // leading: IconButton(
        //   icon: Icon(Icons.arrow_back, color: Color(0xF1FFFFFF)),
        //   onPressed: () {
        //     Navigator.push(
        //       context,
        //       MaterialPageRoute(
        //         builder: (context) => WashScreen(nom: '', matricule: '', tel: '', taille: ''),
        //       ),
        //     );
        //   },
        // ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Détails de la réservation',
                        style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 15),
                     
                      ListTile(
                        leading: Icon(Icons.directions_car, color: Color.fromARGB(238, 129, 1, 164)),
                        title: Text(
                          carName,  
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text('Taille: $carSize',
                        style: TextStyle(fontSize: 11)),  
                        trailing: Text(
                          registration,  
                          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                        ),
                      ),
                      SizedBox(height: 15),
                     
                      ListTile(
                        leading: Icon(Icons.calendar_today, color: Color.fromARGB(238, 129, 1, 164)),
                        title: Text(
                          'Temps de lavage:',
                          style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                        ),
                        trailing: Text(
                          bookingTime,  
                          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                        ),
                      ),
                      SizedBox(height: 15),
                      Center(
                        child: Text(
                          '--------------------------------------------------------',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ),
                      ListTile(
                        leading: Icon(Icons.attach_money, color: Color.fromARGB(238, 129, 1, 164)),
                        title: Text(
                          'Prix ​​de prestation:',
                          style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                        ),
                        trailing: Text(
                          '200 MRU',
                          style: TextStyle(fontSize: 14, color: Colors.green),
                        ),
                      ),
                      SizedBox(height: 15),
                      ListTile(
                        leading: Icon(Icons.money_off, color: Color.fromARGB(238, 129, 1, 164)),
                        title: Text(
                          'Taxe de mobilité:',
                          style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                        ),
                        trailing: Text(
                          '50 MRU',
                          style: TextStyle(fontSize: 14, color: Colors.green),
                        ),
                      ),
                      SizedBox(height: 15),
                      ListTile(
                        leading: Icon(Icons.monetization_on, color: Color.fromARGB(238, 129, 1, 164)),
                        title: Text(
                          'Prix Total:',
                          style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                        ),
                        trailing: Text(
                          '250 MRU',
                          style: TextStyle(fontSize: 14, color: Colors.green),
                        ),
                      ),
                      SizedBox(height: 15),
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: 'Mode de paiement',
                          prefixIcon: Icon(Icons.payment, color: Color.fromARGB(238, 129, 1, 164)),
                        ),
                        items: [
                          DropdownMenuItem(value: 'Non', child: Text('Non')),
                          DropdownMenuItem(value: 'Ok', child: Text('Ok')),
                        ],
                        onChanged: (value) {
                          // Logic when an item is selected (optional)
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Choisissez un mode de paiement';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Center(
                          child: Text(
                            'Confirmation!',
                            style: TextStyle(
                              color: Color.fromARGB(238, 129, 1, 164),
                            ),
                          ),
                        ),
                        content: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            'Votre demande a été envoyée. Nous vous contacterons.',
                            textAlign: TextAlign.center,
                          ),
                        ),
                        actions: [
                          Center(
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop(); // Close the dialog
                              },
                              child: Text('OK'),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  backgroundColor: const Color.fromARGB(220, 35, 102, 195),
                  shadowColor: Colors.black,
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  'Confirmer la commande',
                  style: TextStyle(
                    fontSize: 16,
                    color: const Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
