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
            return const Center(child: CircularProgressIndicator());
          } else {
            return ListView.builder(
              itemCount: controller.myDemands.length,
              itemBuilder: (context, index) {
                final demand = controller.myDemands[index];
                return GestureDetector(
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
                      leading: CircleAvatar(
                        backgroundColor: Colors.blueAccent,
                        child: Text(
                          demand['size']?[0]?.toUpperCase() ?? '',
                          style: const TextStyle(
                            color: Color.fromARGB(238, 129, 1, 164),
                          ),
                        ), // First letter of 'size'
                      ),
                      title: Text(
                        demand['mark'] ?? 'Unknown Mark',
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        demand['bookingTime']?.toString() ?? 'No Time',
                        style: const TextStyle(color: Colors.green),
                      ),
                      trailing: Text(
                        demand['phone'] ?? 'No Phone',
                        style: const TextStyle(
                          color: Color.fromARGB(238, 129, 1, 164),
                        ),
                      ),
                    ),
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
