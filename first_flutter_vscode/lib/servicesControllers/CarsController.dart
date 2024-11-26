// ignore_for_file: avoid_print

import 'package:first_flutter_vscode/servicesControllers/baseUrlAPI.dart';
import 'package:get/get.dart';
import 'dart:convert'; // For json decoding
import 'package:http/http.dart' as http;

class Carscontroller extends GetxController {
  List<dynamic> carsPrencip = [];
  List<dynamic> mycars = [];
  void getcarsPrencipdata() async {
    String url = "${BaseUrlAPI().baseUrl}/get-carprensip";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      carsPrencip = data;
      print("the data is : ");
      print(data);

      update();
    }
  }

  void getcarsdata() async {
    String url = "${BaseUrlAPI().baseUrl}/get-cars";
    final response = await http.post(
      Uri.parse(url),
      headers: {
        "Content-Type": "application/json", // Set the content type to JSON
      },
      body: jsonEncode({
        "id": "1234",
      }),
    );
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      mycars = data;
      print("the data is : ");
      print(data);

      update();
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getcarsPrencipdata();
    getcarsdata();
  }
}
