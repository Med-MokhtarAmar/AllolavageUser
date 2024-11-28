// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/timezone.dart' as tz;

class Servicecontroller extends GetxController {
  List<Map<String, String>> mycars = [];
  List<Map<String, String>> mainServices = [];
  List<Map<String, String>> myDemands = [];
  late SharedPreferences prefs;
  String idUser = "";
  Future<void> loadSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
    idUser = prefs.getString('key') ?? "";
    update();
  }

  Future<void> saveToPreferences(String value) async {
    await prefs.setString('key', value);
    idUser = value;
    loadSharedPreferences();
  }

  Future<void> getCarsData() async {
    print("the getCarsData function ");
    try {
      // Reference the Firestore collection
      CollectionReference carsCollection =
          FirebaseFirestore.instance.collection('cars');

      // Get the data from Firestore
      QuerySnapshot querySnapshot = await carsCollection.get();

      // Clear the list to avoid duplicates
      mycars.clear();

      // Iterate through the documents and add them to the list
      for (var doc in querySnapshot.docs) {
        mycars.add({
          "id": doc.id,
          "size": doc["size"] ?? "",
          "mark": doc["mark"] ?? "",
          "iduser": doc["iduser"] ?? "",
          "Numero": doc["numero"] ?? "",
          "phone": doc["phone"] ?? "",
        });
      }
      update();

      print("Cars data fetched successfully");
    } catch (e) {
      print("Error fetching car data: $e");
    }
  }

  Future<void> getDemandsData() async {
    print("Fetching demands data...");
    try {
      // Reference the Firestore collection
      CollectionReference demandsCollection =
          FirebaseFirestore.instance.collection('demands');

      // Get the data from Firestore
      QuerySnapshot querySnapshot = await demandsCollection.get();

      // Clear the list to avoid duplicates
      myDemands.clear();

      // Iterate through the documents and add them to the list
      for (var doc in querySnapshot.docs) {
        myDemands.add({
          "id": doc.id,
          "model": doc["model"] ?? "",
          "size": doc["size"] ?? "",
          "phone": doc["phone"] ?? "",
          "carNumero": doc["carNumero"] ?? "",
          "gpsLocation": doc["gpsLocation"] ?? "",
          "carId": doc["carId"] ?? "",
          "prix": doc["prix"].toString() ?? "",
          "bookingTime": doc["bookingTime"]?.toDate() ??
              null, // Converts Firestore Timestamp to DateTime
          "isDone": doc["isDone"] ?? false,
          "isCanceld": doc["isCanceld"] ?? false,
          "canceldBy": doc["canceldBy"] ?? "",
          "Moughataa": doc["Moughataa"] ?? "",
          "DoneBy": doc["DoneBy"] ?? "",
          "createdAt": doc["createdAt"]?.toDate() ??
              null, // Converts Firestore Timestamp to DateTime
        }); 
      }

      // Notify listeners or update UI
      update();

      print("Demands data fetched successfully");
    } catch (e) {
      print("Error fetching demands data: $e");
    }
  }

  Future<void> getMainServicesData() async {
    try {
      // Reference the Firestore collection
      CollectionReference carsCollection =
          FirebaseFirestore.instance.collection('mainservices');

      // Get the data from Firestore
      print("gettting the data of mainservices ! ");
      QuerySnapshot querySnapshot = await carsCollection.get();

      // Clear the list to avoid duplicates
      mainServices.clear();

      // Iterate through the documents and add them to the list
      print("inserting the data of mainservices in the list  ");

      for (var doc in querySnapshot.docs) {
        mainServices.add({
          "id": doc.id,
          "model": doc["model"] ?? "",
          "fr_titel": doc["fr_titel"] ?? "",
          "ar_titel": doc["ar_titel"] ?? "",
          "prix": doc["prix"].toString() ?? "0",
          "image": doc["image"] ?? "",
        });
      }
      // "model": "evensis",
      // "ServicePren": "lavage simple",
      // "image": "media/usersimages/logo.png",
      // "prix": 1000,
      update();
      print("Cars data fetched successfully: $mainServices");
    } catch (e) {
      print("Error fetching car data: $e");
    }
  }

  Future<QuerySnapshot?> getMainServicesDataByCar({String? carId}) async {
    try {
      // Reference the Firestore collection
      CollectionReference carsCollection =
          FirebaseFirestore.instance.collection('mainservices');

      print("Getting the data of mainservices...");

      // Filter the query if carId is provided
      Query query = carsCollection;
      if (carId != null) {
        query = query.where('carId', isEqualTo: carId);
      }

      QuerySnapshot querySnapshot = await query.get();

      print(
          "Data fetched successfully: ${querySnapshot.docs.length} documents");
      return querySnapshot;
    } catch (e) {
      print("Error fetching car data: $e");
      return null;
    }
  }

  Future<Position> getCurrentLocation() async {
    // Check if location services are enabled
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Get.snackbar("Location", "Location service is disabled");
      return Future.error("Location services are disabled");
    }

    // Check location permissions
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      // Request permission if not granted
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Handle the case where permission is still denied
        return Future.error("Location permission denied");
      }
    }

    // Check if permission is permanently denied
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          "Location permission is permanently denied, we cannot request permissions.");
    }

    // Fetch the current position if permission is granted
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future<bool> createCar(
      String mark, String size, String numero, String phone) async {
    final mylocation = tz.getLocation('Africa/Nouakchott');

    DateTime localTime = tz.TZDateTime.now(mylocation);
    try {
      // Adding a car document to the Firestore collection
      await FirebaseFirestore.instance.collection('cars').add({
        'iduser': idUser, // Updated key for consistent naming
        'mark': mark,
        'numero': numero, // Changed to match the parameter casing
        'size': size,
        'phone': phone,
        'createAt': localTime
      });
      getCarsData();
      update();
      print('car created ------------'); // Better error logging

      return true; // Success
    } catch (e) {
      print('Failed to create car: ---------- $e'); // Better error logging
      return false; // Failure
    }
  }

  String dateFormat(DateTime date) {
    return DateFormat.yMd().add_jm().format(date);
  }

  Future<bool> createServiceDemand(
    String numero,
    String phone,
    String model,
    String size,
    int prix,
    String carId,
    String gpsLocation,
    String moghataa,
    String bookingTime,
    List<QueryDocumentSnapshot> selectedServices,
  ) async {
    try {
      // Prepare data to be added
      Map<String, dynamic> demandData = {
        'model': model,
        'size': size,
        'phone': phone,
        'carNumero': numero,
        'gpsLocation': gpsLocation,
        'carId': carId,
        'prix': prix,
        'bookingTime': bookingTime,
        'isDone': false,
        'isCanceld': false,
        'canceldBy': "",
        'Moughataa': moghataa,
        'DoneBy': "",
        'createdAt': FieldValue.serverTimestamp(),
      };

      // Optionally add the selected services if you want to store them
      if (selectedServices.isNotEmpty) {
        demandData['selectedServices'] = selectedServices.map((service) {
          // If you want to add service details like name and price
          return {
            'serviceName': service['fr_titel'],
            'servicePrice': service['prix'],
          };
        }).toList();
      }

      // Adding a car document to the Firestore collection
      await FirebaseFirestore.instance.collection('demands').add(demandData);

      // Call method to refresh or update data
      getCarsData();
      update(); // If update is a method you want to trigger

      print('Demand created successfully'); // Better success logging
      return true; // Return success
    } catch (e) {
      print(
          'Failed to create demand: $e'); // Improved error logging with detailed message
      return false; // Return failure
    }
  }

  Future<void> deleteCarById(String id) async {
    try {
      // Get the documents matching the query
      await FirebaseFirestore.instance.collection('cars').doc(id).delete();

      print("Car with ID $id deleted successfully.");
      Get.snackbar("", "the car i deleted succesfuly");
      getCarsData();
    } catch (e) {
      Get.snackbar("", "exception in deleting the car");

      print("Error deleting car: $e");
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getCarsData();
    getMainServicesData();
    loadSharedPreferences();
    getDemandsData();
  }
}
