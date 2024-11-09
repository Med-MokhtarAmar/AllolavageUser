// ignore_for_file: prefer_const_constructors

import 'package:first_flutter_vscode/servicesControllers/CarsController.dart';
import 'package:first_flutter_vscode/servicesControllers/baseUrlAPI.dart';
import 'package:flutter/material.dart';
import 'package:first_flutter_vscode/screens/home/homecar.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String query = ''; // Variable pour stocker la requête de recherche
  final Carscontroller carsController = Get.put(Carscontroller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        backgroundColor: const Color.fromARGB(220, 35, 102, 195),
        shadowColor: Colors.black,
        elevation: 10,
        titleTextStyle: TextStyle(color: Color(0xF1FFFFFF), fontSize: 18),
        // leading: IconButton(
        //   icon: Icon(Icons.arrow_back, color: Color(0xF1FFFFFF)),
        //   onPressed: () {
        //     Navigator.pop(context);
        //   },
        // ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    query = value; // Met à jour la requête de recherche
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Rechercher une voiture...',
                  prefixIcon: Icon(Icons.search,
                      color: const Color.fromARGB(255, 78, 79, 79)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: const Color.fromARGB(255, 219, 219, 223),
                  contentPadding: EdgeInsets.all(16.0),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Informations sur lavage pour de voiture',
                  style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              height: 300, // Hauteur souhaitée pour le ListView
              child: GetBuilder<Carscontroller>(
                builder: (controller) {
                  // Check if the data is available
                  if (controller.carsPrencip.isEmpty) {
                    return Center(
                        child:
                            CircularProgressIndicator()); // Show loading spinner while waiting for data
                  } else {
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.carsPrencip.length,
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      itemBuilder: (context, index) {
                        // HomeCar car = carList[index];
                        var car = controller.carsPrencip[index];

                        if (query.isNotEmpty &&
                            !car['ServicePren']
                                .toLowerCase()
                                .contains(query.toLowerCase()) &&
                            !car['model']
                                .toLowerCase()
                                .contains(query.toLowerCase())) {
                          return SizedBox.shrink();
                        }

                        return Padding(
                          padding: EdgeInsets.only(
                              top: 5.0, right: 10.0, bottom: 25.0),
                          child: Container(
                            width: 160,
                            padding: EdgeInsets.only(
                                top: 0.0, left: 0.0, right: 0.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      const Color.fromARGB(255, 134, 134, 134)
                                          .withOpacity(0.4),
                                  spreadRadius: 2,
                                  blurRadius: 4,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ClipRRect(
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(
                                            10.0)), // Applique le borderRadius uniquement en haut
                                    child: Image.network(
                                        "${BaseUrlAPI().baseUrlimage}${car['image']}")

                                    // Display car image
                                    ),

                                //  Image.asset(
                                //   car images,
                                //   height: 130,
                                //   width: 160,
                                //   fit: BoxFit.cover,
                                // ),
                                // ),
                                SizedBox(height: 20.0),
                                Text(
                                  '${car['model']}',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(238, 129, 1, 164),
                                  ),
                                ),
                                SizedBox(height: 6.0),
                                Text(
                                  '${car['ServicePren']}',
                                  style: TextStyle(
                                    fontSize: 11.0,
                                    color: Color.fromARGB(237, 93, 93, 93),
                                  ),
                                ),
                                SizedBox(height: 4.0),
                                Text(
                                  '${car['prix']} MRU',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.green,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );

                    // Build the list view with the fetched data
                    // return ListView.builder(
                    //   itemCount: controller.carsPrencip.length,
                    //   itemBuilder: (context, index) {
                    //     var car =
                    //         controller.carsPrencip[index]; // Get each car map
                    //     return ListTile(
                    //       title: Text(
                    //           car['model'] ?? 'No model'), // Access car's model
                    //       subtitle: Text(car['ServicePren'] ??
                    //           'No service type'), // Access car's service type
                    //       leading: car['image'] != null
                    //           ? Image.network(
                    //               "${BaseUrlAPI().baseUrlimage}/${car['image']}") // Display car image
                    //           : null,
                    //       trailing: Text(
                    //           '\$${car['prix'] ?? 0}'), // Display car price
                    //     );
                    //   },
                    // );
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'services',
                  style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Container(
              height: 300,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: ServiceList.length,
                padding: EdgeInsets.symmetric(vertical: 8.0),
                itemBuilder: (context, index) {
                  HomeService service = ServiceList[index];
                  return Padding(
                    padding: EdgeInsets.only(
                        top: 5.0, left: 4, right: 6.0, bottom: 90.0),
                    child: Container(
                      width: 160,
                      padding: EdgeInsets.only(top: 0.0, left: 0.0, right: 0.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromARGB(255, 134, 134, 134)
                                .withOpacity(0.4),
                            spreadRadius: 2,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(
                                    10.0)), // Applique le borderRadius uniquement en haut
                            child: Image.asset(
                              service.images,
                              height: 100,
                              width: 160,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(height: 15.0),
                          Text(
                            '${service.Service}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(238, 129, 1, 164),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
