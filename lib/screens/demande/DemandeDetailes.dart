import 'package:allolavage/servicesControllers/serviceController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'wash_screen.dart';

class DemandeDetailes extends StatefulWidget {
  final Map<String, dynamic> demande;
  const DemandeDetailes({
    super.key,
    required this.demande,
  });

  @override
  State<DemandeDetailes> createState() => _DemandeDetailesState();
}

class _DemandeDetailesState extends State<DemandeDetailes> {
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
                          widget.demande['model'] ?? " ",
                          style: const TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                            'Taille: ${widget.demande['size'] ?? " "}',
                            style: const TextStyle(fontSize: 11)),
                        trailing: Text(
                          widget.demande['numero'] ?? " ",
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
                          widget.demande['bookingTime'] ?? " ",
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
                        widget.demande['selectedServices'].length,
                        (index) => ListTile(
                          leading: const Icon(Icons.attach_money,
                              color: Color.fromARGB(238, 129, 1, 164)),
                          title: Text(
                            '${widget.demande['selectedServices'][index]["serviceName"]} :',
                            style: const TextStyle(
                                fontSize: 10, fontWeight: FontWeight.bold),
                          ),
                          trailing: Text(
                            "${widget.demande['selectedServices'][index]["servicePrice"]}",
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
                          '${widget.demande['prix'] ?? " "}',
                          style: const TextStyle(
                              fontSize: 14, color: Colors.green),
                        ),
                      ),
                      const SizedBox(height: 15),
                      // DropdownButtonFormField<String>(
                      //   decoration: const InputDecoration(
                      //     labelText: 'Mode de paiement',
                      //     prefixIcon: Icon(Icons.payment,
                      //         color: Color.fromARGB(238, 129, 1, 164)),
                      //   ),
                      //   items: const [
                      //     DropdownMenuItem(value: 'Non', child: Text('Non')),
                      //     DropdownMenuItem(value: 'Ok', child: Text('Ok')),
                      //     DropdownMenuItem(value: 'Ok', child: Text('Ok')),
                      //     DropdownMenuItem(value: 'Ok', child: Text('Ok')),
                      //   ],
                      //   onChanged: (value) {
                      //     // Logic when an item is selected (optional)
                      //   },

                      // ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // ElevatedButton(
              //   onPressed: () {
              //     // createDemande();
              //   },
              //   style: ElevatedButton.styleFrom(
              //     padding: const EdgeInsets.symmetric(vertical: 16.0),
              //     backgroundColor: const Color.fromARGB(220, 35, 102, 195),
              //     shadowColor: Colors.black,
              //     elevation: 10,
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(30),
              //     ),
              //   ),
              //   child: const Text(
              //     'Confirmer la commande',
              //     style: TextStyle(
              //       fontSize: 16,
              //       color: Color.fromARGB(255, 255, 255, 255),
              //     ),
              //   ),
              // ),
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
