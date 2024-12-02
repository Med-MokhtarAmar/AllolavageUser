import 'package:allolavage/screens/auth/login.dart';
import 'package:allolavage/servicesControllers/serviceController.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Otp extends StatefulWidget {
  final String sms;
  final String tel;
  final String adress;
  final String pwd;

  // Constructor to accept the parameters
  const Otp({
    super.key,
    required this.sms,
    required this.tel,
    required this.adress,
    required this.pwd,
  });

  @override
  _OtpState createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  final Servicecontroller controller = Get.put(Servicecontroller());
  TextEditingController otpController = TextEditingController();
  void createAccount() async {
    if (otpController.text == widget.sms) {
      try {
        // Add user data to Firestore
        await FirebaseFirestore.instance.collection('users').add({
          "phone": widget.tel,
          "password": controller.hash(widget.pwd) ,
          "adress": widget.adress,
          "isActive": true,
        });
        Get.offAll(() => login()); // Navigate to Login screen

        print("Data inserted successfully.");
      } catch (e) {
        print(e);
      }
    } else {
      Get.snackbar("SMS Verification", "Incorrect code.");
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(220, 35, 102, 195),
        shadowColor: const Color.fromARGB(255, 0, 0, 0),
        elevation: 10,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: otpController,
              decoration: const InputDecoration(
                labelText: 'SMS Code',
                prefixIcon:
                    Icon(Icons.sms, color: Color.fromARGB(238, 129, 1, 164)),
              ),
              keyboardType: TextInputType.phone,
              maxLength: 6,
              validator: (value) {
                if (value == null || value.isEmpty || value.length != 6) {
                  return 'Enter a valid 6-digit code.';
                }
                return null;
              },
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: createAccount, // Call the createAccount function
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(220, 35, 102, 195),
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 70, vertical: 18),
                textStyle: const TextStyle(fontSize: 16),
                shadowColor: Colors.black,
                elevation: 15,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text('Confirm'),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
