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
  String query = '';
  final Carscontroller carsController = Get.put(Carscontroller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        backgroundColor: const Color.fromARGB(220, 35, 102, 195),
        shadowColor: Colors.black,
        elevation: 10,
        titleTextStyle: const TextStyle(color: Color(0xF1FFFFFF), fontSize: 18),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10.0),
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
                  prefixIcon: const Icon(Icons.search,
                      color: Color.fromARGB(255, 78, 79, 79)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: const Color.fromARGB(255, 219, 219, 223),
                  contentPadding: const EdgeInsets.all(16.0),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            const Padding(
              padding: EdgeInsets.only(left: 8.0),
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
              padding: const EdgeInsets.symmetric(horizontal: 16),
              height: 300,
              child: GetBuilder<Carscontroller>(
                builder: (controller) {
                  if (controller.carsPrencip.isEmpty) {
                    return const Center(
                        child: CircularProgressIndicator()); // Loading indicator
                  } else {
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.carsPrencip.length,
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      itemBuilder: (context, index) {
                        var car = controller.carsPrencip[index];

                        if (query.isNotEmpty &&
                            !car['ServicePren']
                                .toLowerCase()
                                .contains(query.toLowerCase()) &&
                            !car['model']
                                .toLowerCase()
                                .contains(query.toLowerCase())) {
                          return const SizedBox.shrink();
                        }

                        return Padding(
                          padding: const EdgeInsets.only(
                              top: 5.0, right: 10.0, bottom: 25.0),
                          child: Container(
                            width: 160,
                            padding: const EdgeInsets.all(8.0),
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
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(10.0)),
                                  child: Image.network(
                                    "${BaseUrlAPI().baseUrlimage}${car['image']}",
                                    height: 130,
                                    width: 160,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(height: 20.0),
                                Text(
                                  '${car['model']}',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(238, 129, 1, 164),
                                  ),
                                ),
                                const SizedBox(height: 6.0),
                                Text(
                                  '${car['ServicePren']}',
                                  style: const TextStyle(
                                    fontSize: 11.0,
                                    color: Color.fromARGB(237, 93, 93, 93),
                                  ),
                                ),
                                const SizedBox(height: 4.0),
                                Text(
                                  '${car['prix']} MRU',
                                  style: const TextStyle(
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
                  }
                },
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Services',
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
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                itemBuilder: (context, index) {
                  HomeService service = ServiceList[index];
                  return Padding(
                    padding: const EdgeInsets.only(
                        top: 5.0, left: 4, right: 6.0, bottom: 90.0),
                    child: Container(
                      width: 160,
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromARGB(255, 134, 134, 134)
                                .withOpacity(0.4),
                            spreadRadius: 2,
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(10.0)),
                            child: Image.asset(
                              service.images,
                              height: 100,
                              width: 160,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(height: 15.0),
                          Text(
                            '${service.Service}',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
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
 