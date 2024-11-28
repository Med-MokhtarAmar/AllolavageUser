// ignore_for_file: avoid_print, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import '../../servicesControllers/serviceController.dart';
import '../voiture/ConfirmationScreen.dart';

import 'package:get/get.dart';

import '../voiture/car_screen.dart';

class WashScreen extends StatefulWidget {
  final String matricule;
  final String nom;
  final String carId;
  final String tel;
  final String size;
  const WashScreen(
      {super.key,
      required this.matricule,
      required this.nom,
      required this.tel,
      required this.size,
      required this.carId});
  @override
  // ignore: library_private_types_in_public_api
  _WashScreenState createState() => _WashScreenState();
}

class _WashScreenState extends State<WashScreen> {
  final Servicecontroller carsController = Get.put(Servicecontroller());
  List<QueryDocumentSnapshot> servicesPrinsipales = [];
  List<QueryDocumentSnapshot> selectedServices = [];
  bool isservicesPrinsipalesLoading = false;
  bool isServicesPrinsipalesEmpty = false;
  int prix = 0;
  List<QueryDocumentSnapshot> secondServices = [];
  bool issecondServicesLoading = false;
  bool issecondServicesEmpty = false;

  @override
  void initState() {
    super.initState();
    fetchServicesPrinsipales();
    fetchSecondServices();
  }

  void fetchSecondServices() async {
    isservicesPrinsipalesLoading = true;
    try {
      QuerySnapshot? servicesData = await FirebaseFirestore.instance
          .collection('secondservices')
          .where('size', isEqualTo: widget.size)
          .get();
      if (servicesData != null && servicesData.docs.isNotEmpty) {
        setState(() {
          secondServices = servicesData.docs;
          isservicesPrinsipalesLoading = false;
        });
      } else {
        issecondServicesLoading = true;
        issecondServicesLoading = false;

        print("No data found or an error occurred.");
      }
    } catch (e) {
      issecondServicesLoading = false;

      print("Error fetching services: $e");
    }
  }

  void fetchServicesPrinsipales() async {
    isservicesPrinsipalesLoading = true;
    try {
      QuerySnapshot? servicesData = await FirebaseFirestore.instance
          .collection('mainservices')
          .where('size', isEqualTo: widget.size)
          .get();
      if (servicesData != null && servicesData.docs.isNotEmpty) {
        setState(() {
          servicesPrinsipales = servicesData.docs;
          isservicesPrinsipalesLoading = false;
        });
      } else {
        isServicesPrinsipalesEmpty = true;
        isservicesPrinsipalesLoading = false;

        print("No data found or an error occurred.");
      }
    } catch (e) {
      isservicesPrinsipalesLoading = false;

      print("Error fetching services: $e");
    }
  }

  bool brosage1 = false;
  bool brosage2 = false;
  final Servicecontroller controller = Get.put(Servicecontroller());

  final _formKey = GlobalKey<FormState>();
  String _selectedDate = '';
  String? _selectedTime;
  String address = '';

  String _model = '';
  String _size = '';
  String _registration = '';
  String _bookingTime = '';
  Position? mylocation;

  final List<String> _timeOptions = [
    '08:00',
    '08:30',
    '09:00',
    '09:30',
    '10:00',
    '10:30',
    '11:00',
    '11:30',
    '12:00',
    '12:30',
    '13:00',
    '13:30',
    '14:00',
    '14:30',
    '15:00',
    '15:30',
    '16:00',
    '16:30',
    '17:00',
    '17:30',
    '18:00',
    '18:30',
  ];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2025),
    );
    if (pickedDate != null) {
      setState(() {
        _selectedDate = DateFormat('dd/MM/yyyy').format(pickedDate);
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Vérifiez si au moins une case à cocher est sélectionnée
      if (2 == 4) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content:
                Text('Veuillez sélectionner au moins un service de lavage.'),
            duration: Duration(seconds: 2),
          ),
        );
        return;
      }

      _formKey.currentState!.save();
      _model = widget.nom;
      _size = widget.size;
      _registration = widget.matricule;
      _bookingTime = '$_selectedDate $_selectedTime';

      Get.to(ConfirmationScreen(
        prix: prix,
        selectedServices: secondServices,
        model: _model,
        size: _size,
        bookingTime: _bookingTime,
        phone: widget.tel,
        carId: widget.carId,
        gpsLocation: mylocation != null ? mylocation.toString() : " ",
        numero: widget.matricule,
        moghataa: address,
      ));
    }
  }

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
    getlocation();
  }

  void getlocation() async {
    try {
      mylocation = await controller.getCurrentLocation();
      print("the location is $mylocation ");
      print(mylocation);
    } catch (e) {
      print("we can not get the location !!!!!!!!!!!!!!!!!!!!!!! ");
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false, // Hides the back button

        title: const Text('Lavage'),
        backgroundColor: const Color.fromARGB(220, 35, 102, 195),
        shadowColor: Colors.black,
        elevation: 10,
        titleTextStyle: const TextStyle(color: Color(0xF1FFFFFF), fontSize: 18),
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back, color: Color(0xF1FFFFFF)),
        //   onPressed: () {
        //     Get.to(CarScreen());
        //   },
        // ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // the car card ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                Card(
                  elevation: 5,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    title: Text(
                      '${widget.nom}',
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      '${widget.matricule}',
                      style: const TextStyle(fontSize: 14, color: Colors.green),
                    ),
                    trailing: Text(
                      '${widget.tel}',
                      style: const TextStyle(
                          fontSize: 14,
                          color: Color.fromARGB(238, 129, 1, 164)),
                    ),
                    leading: const Icon(Icons.directions_car,
                        color: Color.fromARGB(238, 129, 1, 164)),
                  ),
                ),
                const SizedBox(height: 10),
                // the titel "Principales Prestations" ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: 30,
                      height: 1,
                      color: Colors.black38,
                    ),
                    const Icon(Icons.local_car_wash,
                        color: Color.fromARGB(220, 35, 102, 195), size: 20),
                    const SizedBox(width: 8),
                    const Text(
                      'Principales Prestations',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    Container(
                      width: 30,
                      height: 1,
                      color: Colors.black38,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    // the list that shows the mainservices  ++++++++++++++++++++++++++++++++++++++++++++++++++++++++

                    Column(
                      children: List.generate(
                        servicesPrinsipales.length,
                        (index) => Card(
                          elevation: 5,
                          child: InkWell(
                            onTap: () {
                              final int servicePrix = servicesPrinsipales[index]
                                      ['prix'] is int
                                  ? servicesPrinsipales[index]['prix']
                                  : int.parse(servicesPrinsipales[index]['prix']
                                      .toString());

                              if (selectedServices
                                  .contains(servicesPrinsipales[index])) {
                                selectedServices
                                    .remove(servicesPrinsipales[index]);

                                prix -= servicePrix;
                              } else {
                                selectedServices
                                    .add(servicesPrinsipales[index]);

                                prix += servicePrix;
                              }
                              setState(() {});
                            },
                            child: ListTile(
                              leading: const Icon(Icons.cleaning_services,
                                  color: Color.fromARGB(238, 129, 1, 164)),
                              title: Text(
                                "${servicesPrinsipales[index]['fr_titel']}",
                                style: const TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                '${servicesPrinsipales[index]['prix']} \$',
                                style: const TextStyle(
                                    color: Colors.green, fontSize: 12.0),
                              ),
                              trailing: selectedServices
                                      .contains(servicesPrinsipales[index])
                                  ? const Icon(
                                      Icons.check_box,
                                      color: Color.fromARGB(238, 129, 1, 164),
                                    )
                                  : const Icon(Icons.check_box_outline_blank),
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 60),

                    //  the titel "Prestations Supplémentaires"
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: 30,
                          height: 1,
                          color: Colors.black38,
                        ),
                        const Icon(Icons.local_car_wash,
                            color: Color.fromARGB(220, 35, 102, 195), size: 20),
                        const SizedBox(width: 8),
                        const Text(
                          'Prestations Supplémentaires',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        Container(
                          width: 30,
                          height: 1,
                          color: Colors.black38,
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),

                    Column(
                      children: List.generate(
                        secondServices.length,
                        (index) => Card(
                          elevation: 5,
                          child: InkWell(
                            onTap: () {
                              final int servicePrix = secondServices[index]
                                      ['prix'] is int
                                  ? secondServices[index]['prix']
                                  : int.parse(
                                      secondServices[index]['prix'].toString());
                              if (selectedServices
                                  .contains(secondServices[index])) {
                                selectedServices.remove(secondServices[index]);
                                prix -= servicePrix;
                              } else {
                                selectedServices.add(secondServices[index]);
                                prix += servicePrix;
                              }
                              setState(() {});
                            },
                            child: ListTile(
                              leading: const Icon(Icons.cleaning_services,
                                  color: Color.fromARGB(238, 129, 1, 164)),
                              title: Text(
                                "${secondServices[index]['fr_titel']}",
                                style: const TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                '${secondServices[index]['prix']} \$',
                                style: const TextStyle(
                                    color: Colors.green, fontSize: 12.0),
                              ),
                              trailing: selectedServices
                                      .contains(secondServices[index])
                                  ? const Icon(
                                      Icons.check_box,
                                      color: Color.fromARGB(238, 129, 1, 164),
                                    )
                                  : const Icon(Icons.check_box_outline_blank),
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    TextFormField(
                      readOnly: true,
                      onTap: () => _selectDate(context),
                      decoration: const InputDecoration(
                        labelText: 'Date de lavage',
                        labelStyle:
                            TextStyle(color: Color.fromARGB(255, 81, 80, 80)),
                        prefixIcon: Icon(Icons.calendar_today,
                            color: Color.fromARGB(238, 129, 1, 164)),
                      ),
                      controller: TextEditingController(text: _selectedDate),
                      validator: (value) {
                        if (_selectedDate.isEmpty) {
                          return 'Veuillez sélectionner une date';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),

                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        labelText: 'Heure de lavage',
                        labelStyle:
                            TextStyle(color: Color.fromARGB(255, 81, 80, 80)),
                        prefixIcon: Icon(Icons.access_time,
                            color: Color.fromARGB(238, 129, 1, 164)),
                      ),
                      items: _timeOptions.map((String time) {
                        return DropdownMenuItem<String>(
                          value: time,
                          child: Text(time),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedTime = newValue;
                        });
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Adresse',
                        labelStyle:
                            TextStyle(color: Color.fromARGB(255, 81, 80, 80)),
                        prefixIcon: Icon(Icons.location_on,
                            color: Color.fromARGB(238, 129, 1, 164)),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Veuillez entrer votre adresse';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        address = value ?? '';
                      },
                    ),

                    const SizedBox(height: 10),
                    Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        decoration: const BoxDecoration(
                            border: Border(
                                bottom:
                                    BorderSide(color: Colors.black, width: 1))),
                        child: mylocation == null
                            ? const Text("we could not get your location !")
                            : Text(
                                "location : ${mylocation?.latitude} ,  ${mylocation?.longitude}"),
                      ),
                    ),
                    const SizedBox(height: 15),

                    Center(
                      child: Text("le prix total $prix UM",
                          style: const TextStyle(
                              color: Colors.green,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold)),
                    )
                  ],
                ),
                const SizedBox(height: 15),
                ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 85, vertical: 17),
                    backgroundColor: const Color.fromARGB(220, 35, 102, 195),
                  ),
                  child: const Text('Confirmer le lavage',
                      style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
