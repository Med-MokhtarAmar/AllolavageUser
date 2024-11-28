import 'package:allolavage/servicesControllers/serviceController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../washScreen/wash_screen.dart';

class CarScreen extends StatefulWidget {
  @override
  _CarScreenState createState() => _CarScreenState();
}

class _CarScreenState extends State<CarScreen> {
  final _formKey = GlobalKey<FormState>();

  List<Map<String, String>> carList = [];
  final Servicecontroller carsController = Get.put(Servicecontroller());

  String mark = '';
  String size = 'Milieu';
  String numero = '';
  String phone = '';
  bool isloading = false;
  void addCar(BuildContext context) async {
    setState(() {
      isloading = true;
    });
    if (numero == "") {
      numero = "sens numero";
    }
    bool success = await carsController.createCar(mark, size, numero, phone);
    if (success) {
      Navigator.of(context).pop();
      setState(() {
        isloading = false;
        mark = '';
        size = 'Milieu';
        numero = '';
        phone = '';
      });
      Get.snackbar("", "Car added successfully!");
      print("Car added successfully!");
    } else {
      setState(() {
        isloading = false;
        mark = '';
        size = 'Milieu';
        numero = '';
        phone = '';
      });
      Get.snackbar("", "Failed to add car.");

      print("Failed to add car.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
                centerTitle: true,
        automaticallyImplyLeading: false, // Hides the back button
        title: const Text('Ma Voiture'),
        backgroundColor: const Color.fromARGB(220, 35, 102, 195),
        shadowColor: Colors.black,
        elevation: 10,
        titleTextStyle: const TextStyle(color: Color(0xF1FFFFFF), fontSize: 18),
 
      ),
      body: 
      Column(
        children: [
          const SizedBox(height: 20),
          Expanded(
            child: GetBuilder<Servicecontroller>(builder: (controller) {
              if (controller.mycars.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return ListView.builder(
                  itemCount: carsController.mycars.length,
                  itemBuilder: (context, index) {
                    final car = carsController.mycars[index];

                    return GestureDetector(
                      onTap: () {
                        Get.to(() => WashScreen(
                          carId:car['id'] ?? '' ,
                            nom: car['mark'] ?? '',
                            matricule: car['Numero'] ?? '',
                            tel: car['phone'] ?? ' ? ',
                            size: car['size'] ?? ''));
                      },
                      onLongPress: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                  title: const Text(
                                    "suppretion d' une voiteure une voiture",
                                    style: TextStyle(
                                      fontSize: 25.0,
                                      color: Color.fromARGB(220, 5, 25, 177),
                                    ),
                                  ),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Center(
                                        child: Text(
                                            "do you want to delete this car"),
                                      ),
                                      Row(
                                        children: [
                                          TextButton(
                                            onPressed: () {
                                              controller
                                                  .deleteCarById(car['id']!);
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text('ok'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text('annuler'),
                                          ),
                                        ],
                                      )
                                    ],
                                  ));
                            });
                      },
                      child: Card(
                        color: const Color.fromARGB(255, 239, 239, 249),
                        margin: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 5),
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.blueAccent,
                            child: Text(car['size']?[0] ?? "",
                                style: const TextStyle(
                                    color: Color.fromARGB(238, 129, 1,
                                        164))), // Première lettre de la taille
                          ),
                          title: Text(
                            car['mark'] ?? '',
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            car['Numero'] ?? '',
                            style: const TextStyle(color: Colors.green),
                          ),
                          trailing: Text(car['phone'] ?? '',
                              style: const TextStyle(
                                  color: Color.fromARGB(238, 129, 1, 164))),
                        ),
                      ),
                    );
                  },
                );
              }
            }),

            //  ListView.builder(
            //     itemCount: carList.length,
            //     itemBuilder: (context, index) {
            //       final car = carList[index];

            //       return GestureDetector(
            //         onTap: () {
            //           Navigator.push(
            //             context,
            //             MaterialPageRoute(builder: (context) => WashScreen(nom: car['name'] ?? '',
            //             matricule:car['plate']?? '' ,tel: car['phone'] ?? '' , taille: car['size'] ?? '')),

            //           );
            //         },

            //         child: Card(
            //           color: Color.fromARGB(255, 239, 239, 249),
            //           margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            //           elevation: 10,
            //           shape: RoundedRectangleBorder(
            //             borderRadius: BorderRadius.circular(10),
            //           ),
            //           child: ListTile(
            //             leading: CircleAvatar(
            //               backgroundColor: Colors.blueAccent,
            //               child: Text(car['size']![0],style: TextStyle(color: Color.fromARGB(238, 129, 1, 164))), // Première lettre de la taille
            //             ),
            //             title: Text(car['name'] ?? '',style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold,
            //             ), ),
            //             subtitle: Text(car['plate'] ?? '',style: TextStyle(color: Colors.green),),
            //             trailing: Text(car['phone'] ?? '',style: TextStyle(color: Color.fromARGB(238, 129, 1, 164))),
            //           ),
            //         ),
            //       );
            //     },
            //   ),
          ),
        ],
      ),
     
     
     
     
     
     
     
     
     
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text(
                    'Ajouter une voiture',
                    style: TextStyle(
                      fontSize: 25.0,
                      color: Color.fromARGB(220, 5, 25, 177),
                    ),
                  ),
                  content: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Numéro de téléphone',
                              prefixIcon: Icon(
                                Icons.phone,
                                color: Color.fromARGB(238, 129, 1, 164),
                              ),
                            ),
                            keyboardType: TextInputType.phone,
                            maxLength: 8,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value!.isEmpty || value.length != 8) {
                                return 'Entrez un numéro de téléphone';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              phone = value;
                            },
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Nom de la voiture',
                              prefixIcon: Icon(
                                Icons.directions_car,
                                color: Color.fromARGB(238, 129, 1, 164),
                              ),
                            ),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Veuillez entrer le nom de la voiture';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              mark = value;
                            },
                          ),
                          const SizedBox(height: 20),
                          DropdownButtonFormField<String>(
                            value: size,
                            items: ['Grand', 'Milieu', 'Petit']
                                .map((size) => DropdownMenuItem(
                                      value: size,
                                      child: Text(size),
                                    ))
                                .toList(),
                            decoration: const InputDecoration(
                              labelText: 'Taille de la voiture',
                              prefixIcon: Icon(
                                Icons.height,
                                size: 20.0,
                                color: Color.fromARGB(238, 129, 1, 164),
                              ),
                            ),
                            onChanged: (value) {
                              size = value!;
                            },
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Matricule de la voiture',
                              prefixIcon: Icon(
                                Icons.confirmation_number,
                                color: Color.fromARGB(238, 129, 1, 164),
                              ),
                            ),
                            maxLength: 8,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value!.isNotEmpty && value.length != 8) {
                                return 'Entrez Matricule de la voiture';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              numero = value;
                            },
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Annuler'),
                    ),
                    TextButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate() &&
                            isloading == false) {
                          // _formKey.currentState!.save();

                          addCar(context);

                          // Ferme la boîte de dialogue
                        }
                      },
                      child: isloading
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : const Text('Enregistrer'),
                    ),
                  ],
                );
              },
            );
          },
          backgroundColor: const Color.fromRGBO(230, 222, 232, 1),
          child: const Icon(Icons.add, color: Color.fromARGB(248, 194, 3, 247)),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
