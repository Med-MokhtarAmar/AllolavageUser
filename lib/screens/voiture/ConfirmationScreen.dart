import 'package:allolavage/servicesControllers/serviceController.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'wash_screen.dart';

class ConfirmationScreen extends StatefulWidget {
  // final String model; // Car Name
  // final String size; // Car Size
  // final int prix; // Car Size
  // final String phoneContact; // Registration Number
  // final String registration; // Registration Number
  // final String bookingTime; // Booking Date and Time
  // final List<QueryDocumentSnapshot> selectedServices ;
  final String numero;
  final String phone;
  final String model;
  final String size;
  final int prix;
  final String carId;
  final String gpsLocation;
  final String moghataa;
  final String bookingTime;
  final List<QueryDocumentSnapshot> selectedServices;
  const ConfirmationScreen({
    super.key,
    required this.numero,
    required this.phone,
    required this.model,
    required this.size,
    required this.prix,
    required this.carId,
    required this.gpsLocation,
    required this.moghataa,
    required this.bookingTime,
    required this.selectedServices,
  });

  @override
  State<ConfirmationScreen> createState() => _ConfirmationScreenState();
}

class _ConfirmationScreenState extends State<ConfirmationScreen> {
  final Servicecontroller controller = Get.put(Servicecontroller());

  void alert() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Center(
            child: Text(
              'Confirmation!',
              style: TextStyle(
                color: Color.fromARGB(238, 129, 1, 164),
              ),
            ),
          ),
          content: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
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
                child: const Text('OK'),
              ),
            ),
          ],
        );
      },
    );
  }

  void createDemande() async {
    bool success = await controller.createServiceDemand(
        widget.numero,
        widget.phone,
        widget.model,
        widget.size,
        widget.prix,
        widget.carId,
        widget.gpsLocation,
        widget.moghataa,
        widget.bookingTime,
        widget.selectedServices);

    if (success) {
      Get.snackbar("Demand", "your demmande is created !");
      Navigator.of(context).pop();
      // alert();
    } else {
      Get.snackbar("Demand feild", "your demmande feild !");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false, // Hides the back button
        title: const Text(
          'Confirmation de Lavage',
          style: TextStyle(color: Colors.white, fontSize: 17),
        ),
        backgroundColor: const Color.fromARGB(220, 35, 102, 195),
        shadowColor: Colors.black,
        elevation: 10,
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
                      const Text(
                        'Détails de la réservation',
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 15),

                      ListTile(
                        leading: const Icon(Icons.directions_car,
                            color: Color.fromARGB(238, 129, 1, 164)),
                        title: Text(
                          widget.model,
                          style: const TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text('Taille: ${widget.size}',
                            style: const TextStyle(fontSize: 11)),
                        trailing: Text(
                          widget.numero,
                          style:
                              TextStyle(fontSize: 12, color: Colors.grey[600]),
                        ),
                      ),
                      const SizedBox(height: 15),

                      ListTile(
                        leading: const Icon(Icons.calendar_today,
                            color: Color.fromARGB(238, 129, 1, 164)),
                        title: const Text(
                          'Temps de lavage:',
                          style: TextStyle(
                              fontSize: 10, fontWeight: FontWeight.bold),
                        ),
                        trailing: Text(
                          widget.bookingTime,
                          style:
                              TextStyle(fontSize: 12, color: Colors.grey[600]),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Center(
                        child: Text(
                          '--------------------------------------------------------',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ),
                      // const ListTile(
                      //   leading: Icon(Icons.attach_money, color: Color.fromARGB(238, 129, 1, 164)),
                      //   title: Text(
                      //     'Prix ​​de prestation:',
                      //     style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                      //   ),
                      //   trailing: Text(
                      //     '200 MRU',
                      //     style: TextStyle(fontSize: 14, color: Colors.green),
                      //   ),
                      // ),
                      const SizedBox(height: 15),

                      Column(
                          children: List.generate(
                        widget.selectedServices.length,
                        (index) => ListTile(
                          leading: const Icon(Icons.attach_money,
                              color: Color.fromARGB(238, 129, 1, 164)),
                          title: Text(
                            '${widget.selectedServices[index]["fr_titel"]}  :',
                            style: const TextStyle(
                                fontSize: 10, fontWeight: FontWeight.bold),
                          ),
                          trailing: Text(
                            "${widget.selectedServices[index]["prix"]}",
                            style: const TextStyle(
                                fontSize: 14, color: Colors.green),
                          ),
                        ),
                      )),

                      const SizedBox(height: 15),
                      ListTile(
                        leading: const Icon(Icons.monetization_on,
                            color: Color.fromARGB(238, 129, 1, 164)),
                        title: const Text(
                          'Prix Total:',
                          style: TextStyle(
                              fontSize: 10, fontWeight: FontWeight.bold),
                        ),
                        trailing: Text(
                          '${widget.prix}',
                          style: const TextStyle(
                              fontSize: 14, color: Colors.green),
                        ),
                      ),
                      const SizedBox(height: 15),
                      DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          labelText: 'Mode de paiement',
                          prefixIcon: Icon(Icons.payment,
                              color: Color.fromARGB(238, 129, 1, 164)),
                        ),
                        items: const [
                          DropdownMenuItem(value: 'Non', child: Text('Non')),
                          DropdownMenuItem(value: 'Ok', child: Text('Ok')),
                        ],
                        onChanged: (value) {
                          // Logic when an item is selected (optional)
                        },
                        // validator: (value) {
                        //   if (value == null || value.isEmpty) {
                        //     return 'Choisissez un mode de paiement';
                        //   }
                        //   return null;
                        // },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  createDemande();
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  backgroundColor: const Color.fromARGB(220, 35, 102, 195),
                  shadowColor: Colors.black,
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'Confirmer la commande',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color.fromARGB(255, 255, 255, 255),
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



  // String model
  // ,String size  
  // ,int prix  
  // ,String registration 
  // ,String bookingTime 
  // ,List<QueryDocumentSnapshot> selectedServices 
