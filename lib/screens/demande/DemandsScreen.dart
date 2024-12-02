import 'package:allolavage/screens/demande/DemandeDetailes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../servicesControllers/serviceController.dart';

class DemandSscreen extends StatefulWidget {
  @override
  State<DemandSscreen> createState() => _DemandSscreenState();
}

class _DemandSscreenState extends State<DemandSscreen> {
  final Servicecontroller mycontroller = Get.put(Servicecontroller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false, // Hides the back button
        title: const Text('Réservation'),
        backgroundColor: const Color.fromARGB(220, 35, 102, 195),
        shadowColor: Colors.black,
        elevation: 10,
        titleTextStyle: const TextStyle(color: Color(0xF1FFFFFF), fontSize: 18),
      ),
      body: GetBuilder<Servicecontroller>(
        builder: (controller) {
          if (controller.myDemands.isEmpty) {
            return const Center(child: Text(" il n'ya pas des demandes"));
          } else {
            return ListView.builder(
              itemCount: controller.myDemands.length,
              itemBuilder: (context, index) {
                final demand = controller.myDemands[index];
                return GestureDetector(
                  onTap: () {
                    Get.to(() => DemandeDetailes(demande: demand));
                  },
                  onLongPress: () {
                    _showDeleteDialog(context, demand['id']);
                  },
                  child: Card(
                    color: const Color.fromARGB(255, 239, 239, 249),
                    margin:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      // leading:  ,
                      title: Text(
                        demand['model'] ?? 'Unknown Mark',
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Align(
                        alignment: Alignment.bottomLeft,
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          // mainAxisSize: MainA,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.date_range_outlined,
                                  color: Colors.green,
                                  size: 17,
                                ),
                                Text(
                                  demand['bookingTime']?.toString() ??
                                      'No Time',
                                  style: const TextStyle(color: Colors.green),
                                ),
                              ],
                            ),
                            // ignore: prefer_const_constructors
                            Row(
                              children: [
                                const Icon(
                                  Icons.attach_money_outlined,
                                  color: Color.fromARGB(238, 129, 1, 164),
                                  size: 18,
                                ),
                                Text(
                                  " ${demand['prix']} ",
                                  style: const TextStyle(
                                    color: Color.fromARGB(238, 129, 1, 164),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      trailing: Column(
                        children: [
                          Text(
                            demand['carNumero'],
                            style: const TextStyle(),
                          ),
                          const SizedBox(
                            height: 1,
                          ),
                          Text(
                            demand['phone'] ?? 'No Phone',
                            style: const TextStyle(
                              color: Color.fromARGB(238, 129, 1, 164),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: Align(
                    //     alignment: Alignment.bottomLeft,
                    //     child: Text("data"),
                    //   ),
                    // )
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, String? demandId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "Suppression d'une demande",
            style: TextStyle(
              fontSize: 18.0,
              color: Color.fromARGB(220, 5, 25, 177),
            ),
          ),
          content: const Text(
            "Voulez-vous vraiment supprimer cette demande ?",
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Call delete function from the controller
                // mycontroller.deleteDemandById(demandId ?? '');
                // Navigator.of(context).pop();
              },
              child: const Text('Oui'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Non'),
            ),
          ],
        );
      },
    );
  }
}
