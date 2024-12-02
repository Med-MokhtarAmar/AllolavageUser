// ignore_for_file: avoid_print

import 'package:allolavage/EntryPoint.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/timezone.dart' as tz;
import 'dart:convert'; // For utf8.encode
import 'package:crypto/crypto.dart'; // For sha256

class Servicecontroller extends GetxController {
  bool isCarsEmpty = false;
  bool isdemandsEmpty = false;
  bool isMainservicesEmpty = false;
  bool isMainservicesloading = false;
  Map<String, String> userdata = {};
  List<Map<String, String>> mycars = [];
  List<Map<String, dynamic>> mainServices = [];
  List<Map<String, dynamic>> myDemands = [];
  late SharedPreferences prefs;
  String? idUser;
  String? userAdress;
  String? userPhone;
  String? userName;
  Future<void> loadSharedPreferences() async {
    try {
      prefs = await SharedPreferences.getInstance();
      idUser = prefs.getString('idUser') ?? "";
      print("connected user is $idUser ");
      update();
    } catch (e) {
      print("we can get the id user fron prefs +++++++++++++++++++++++++++");
    }
  }

  Future<void> loadUserData() async {
    try {
      prefs = await SharedPreferences.getInstance();
      userAdress = prefs.getString('userAdress') ?? "no adress";
      userPhone = prefs.getString('userPhone') ?? "no phone";
      userName = prefs.getString('userName') ?? "no name";
      print("connected user is $userName $userPhone $userAdress ");
      update();
    } catch (e) {
      print("we can get the id user fron prefs +++++++++++++++++++++++++++");
    }
  }

  Future<void> saveToPreferences(String value) async {
    try {
      await prefs.setString('idUser', value);
      // idUser = value;
      loadSharedPreferences();
    } catch (e) {}
  }

  Future<void> deleteFromPreferences() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove('idUser'); // Deletes the 'idUser' key
    } catch (e) {
      print("Error deleting from preferences: $e");
    }
  }

  Future<bool> checkIfIdUserExists() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? idUser = prefs.getString('idUser');
    return idUser != null &&
        idUser.isNotEmpty; // Check if idUser is not null or empty
  }

  Future<void> saveUserdataToPreferences(
    String name,
    String phone,
    String adress,
  ) async {
    try {
      await prefs.setString('userAdress', adress);
      await prefs.setString('userPhone', phone);
      await prefs.setString('userName', name);
      loadUserData();
    } catch (e) {}
  }

  Future<void> getCarsData() async {
    print("the getCarsData function ");
    try {
      // Reference the Firestore collection
      CollectionReference carsCollection =
          FirebaseFirestore.instance.collection('cars');

      // Get the data from Firestore
      QuerySnapshot querySnapshot =
          await carsCollection.where("iduser", isEqualTo: idUser).get();

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

  Future<void> login(String tel, String pwd) async {
    String hashpwd =
        hash(pwd); // Assuming `hash` method is implemented for hashing
    try {
      // Reference the Firestore collection
      CollectionReference usersCollection =
          FirebaseFirestore.instance.collection('users');

      // Get the data from Firestore where the phone number matches
      QuerySnapshot querySnapshot =
          await usersCollection.where('phone', isEqualTo: tel).get();

      if (querySnapshot.docs.isEmpty) {
        // Show snackbar if user doesn't exist
        Get.snackbar("User not found", "The phone number $tel does not exist");
      } else {
        // Get the password field from the document and check if it matches
        String storedPassword = querySnapshot.docs[0].get('password');

        if (storedPassword == hashpwd) {
          // Proceed to load shared preferences (you can pass user data here)
          saveToPreferences(querySnapshot.docs[0].id);
          saveUserdataToPreferences(
              querySnapshot.docs[0]['name'] ?? " no name",
              querySnapshot.docs[0]['phone'] ?? " ",
              querySnapshot.docs[0]['adress'] ?? " ");
          // Get.off(() => Entrypoint());
          loadSharedPreferences();

          Get.off(() => Entrypoint());

          update();
        } else {
          // If the passwords don't match, show an error message
          Get.snackbar(
              "Incorrect password", "The entered password is incorrect");
        }
      }

      print("Login attempt completed");
    } catch (e) {
      print("Error during login: $e");
    }
  }

  String hash(String input) {
    // Convert the input string to bytes
    List<int> bytes = utf8.encode(input);

    // Hash the input using SHA-1
    Digest sha1Hash = sha1.convert(bytes);

    // Return the hexadecimal representation of the hash
    return sha1Hash.toString();
  }

  Future<void> getDemandsData() async {
    print("Fetching demands data...");
    try {
      // Reference the Firestore collection
      CollectionReference demandsCollection =
          FirebaseFirestore.instance.collection('demands');

      // Get the data from Firestore
      QuerySnapshot querySnapshot =
          await demandsCollection.where('idUser', isEqualTo: idUser).get();

      // Clear the list to avoid duplicates
      myDemands.clear();

      // Iterate through the documents and add them to the list
      for (var doc in querySnapshot.docs) {
        myDemands.add({
          "id": doc.id,
          "model": doc["model"].toString(),
          "size": doc["size"].toString(),
          "phone": doc["phone"].toString(),
          "carNumero": doc["carNumero"].toString(),
          "carId": doc["carId"] ?? "",
          "prix": doc["prix"].toString(),
          "bookingTime": doc["bookingTime"]
              .toString(), // Converts Firestore Timestamp to DateTime
          "isDone": doc["isDone"].toString(),
          "isCanceld": doc["isCanceld"].toString(),
          "canceldBy": doc["canceldBy"].toString(),
          "Moughataa": doc["Moughataa"].toString(),
          "selectedServices": doc["selectedServices"],
          "DoneBy": doc["DoneBy"].toString(),
          "createdAt": doc["createdAt"]
              ?.toDate() // Converts Firestore Timestamp to DateTime
        });
        isdemandsEmpty = false;
      }
      print(
          " nombre du demande ${myDemands.length} / ${querySnapshot.docs.length} ");
      if (querySnapshot.docs.isEmpty) isdemandsEmpty = true;

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
          "prix": doc["prix"].toString(),
          "image": doc["image"] ?? "",
        });
      }
      // "model": "evensis",
      // "ServicePren": "lavage simple",
      // "image": "media/usersimages/logo.png",
      // "prix": 1000,
      update();
      // print("Cars data fetched successfully: ");
    } catch (e) {
      print("Error fetching car data: $e");
    }
  }

  Future<QuerySnapshot?> getMainServicesDataByCar(String size) async {
    try {
      // Reference the Firestore collection
      CollectionReference carsCollection =
          FirebaseFirestore.instance.collection('mainservices');

      isMainservicesloading = true;
      update();

      Query query = carsCollection;

      QuerySnapshot querySnapshot =
          await query.where('size', isEqualTo: size).get();

      print(
          "Data fetched successfully: ${querySnapshot.docs.length} documents");
      isMainservicesloading = false;
      update();
      return querySnapshot;
    } catch (e) {
      print("Error fetching car data: $e");
      isMainservicesloading = false;
      update();
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
        "idUser": idUser,
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
      getDemandsData();
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

  void loadAllData() async {
    loadSharedPreferences();
    loadUserData();
    getCarsData();
    getMainServicesData();
    getDemandsData();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    loadSharedPreferences();
    loadUserData();
    getCarsData();
    getMainServicesData();
    getDemandsData();
  }
}
