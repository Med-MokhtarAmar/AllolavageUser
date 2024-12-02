import 'package:allolavage/screens/auth/OTP.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../EntryPoint.dart';
import '../page/profile_screen.dart';
import 'login.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController tel = TextEditingController();
  TextEditingController pwd = TextEditingController();
  TextEditingController pwd2 = TextEditingController();
  String adress = "";
  List<Map<String, dynamic>> listMoghataa = [];

  void getMoghataa() async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance.collection('moughataa').get();

      // Extracting data from the snapshot
      listMoghataa = snapshot.docs.map((doc) => doc.data()).toList();
      setState(() {});

      print(listMoghataa); // For debugging: prints the fetched data
    } catch (e) {
      print("Error fetching moughataa: $e");
    }
  }

  bool isloading = false;
  void verifyPhoneNumber() async {
    FirebaseAuth auth = FirebaseAuth.instance;

    await auth.verifyPhoneNumber(
      phoneNumber: "+222" + tel.text,
      verificationCompleted: (PhoneAuthCredential credential) async {
        // Auto-resolves the code and logs the user in
        await auth.signInWithCredential(credential);
        print(
            'Phone number automatically verified and user signed in: ${auth.currentUser}');
      },
      verificationFailed: (FirebaseAuthException e) {
        print('Verification failed: ${e.message}');

        Get.to(() => Otp(
              sms: "123456",
              pwd: pwd.text,
              tel: tel.text,
              adress: adress,
            ));
      },
      codeSent: (String verificationId, int? resendToken) {
        print('Code sent to $tel.text');

        Get.to(() => Otp(
              sms: verificationId,
              pwd: pwd.text,
              tel: tel.text,
              adress: adress,
            ));
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        print('Auto-retrieval timeout');
      },
    );
  }

  // void verification(String phoneNumber, String smsCode) async {
  //   FirebaseAuth auth = FirebaseAuth.instance;

  //   await auth.verifyPhoneNumber(
  //     phoneNumber: phoneNumber,
  //     codeSent: (String verificationId, int? resendToken) async {
  //       // Create a PhoneAuthCredential with the SMS code
  //       PhoneAuthCredential credential = PhoneAuthProvider.credential(
  //         verificationId: verificationId,
  //         smsCode: smsCode,
  //       );

  //       // Sign in the user
  //       await auth.signInWithCredential(credential);
  //     },
  //     verificationCompleted: (PhoneAuthCredential credential) async {
  //       // Automatically sign in the user
  //       await auth.signInWithCredential(credential);
  //     },
  //     verificationFailed: (FirebaseAuthException e) {
  //       print("Verification failed: ${e.message}");
  //     },
  //     codeAutoRetrievalTimeout: (String verificationId) {
  //       print("Code retrieval timeout");
  //     },
  //   );
  // }

 

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMoghataa();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Créer un compte',
            style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromARGB(220, 35, 102, 195),
        shadowColor: const Color.fromARGB(255, 0, 0, 0),
        elevation: 10,
      ),
      body: isloading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: name,
                      decoration: const InputDecoration(
                        labelText: 'Nom Personnel',
                        prefixIcon: Icon(Icons.person,
                            color: Color.fromARGB(238, 129, 1, 164)),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: tel,
                      decoration: const InputDecoration(
                        labelText: 'Numéro de téléphone',
                        prefixIcon: Icon(Icons.phone,
                            color: Color.fromARGB(238, 129, 1, 164)),
                      ),
                      keyboardType: TextInputType.phone,
                      maxLength: 8,
                    ),
                    TextFormField(
                      controller: pwd,
                      decoration: const InputDecoration(
                        labelText: 'mot de pass',
                        prefixIcon: Icon(Icons.phone,
                            color: Color.fromARGB(238, 129, 1, 164)),
                      ),
                      keyboardType: TextInputType.phone,
                      maxLength: 8,
                    ),
                    TextFormField(
                      controller: pwd2,
                      decoration: const InputDecoration(
                        labelText: 'confirmation du mot de pass',
                        prefixIcon: Icon(Icons.phone,
                            color: Color.fromARGB(238, 129, 1, 164)),
                      ),
                      keyboardType: TextInputType.phone,
                      maxLength: 8,
                    ),
                    const SizedBox(height: 20),
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        labelText: 'Lieu de résidence',
                        prefixIcon: Icon(Icons.location_on,
                            color: Color.fromARGB(238, 129, 1, 164)),
                      ),

                      items: listMoghataa
                          .map<DropdownMenuItem<String>>((moghataa) {
                        return DropdownMenuItem<String>(
                          value: moghataa['fr_name'],
                          child: Text(moghataa['fr_name']),
                        );
                      }).toList(),

                      onChanged: (value) {
                        setState(() {
                          adress = value!;
                        });
                      },
                      // validator: (value) {
                      //   if (value == null || value.isEmpty) {
                      //     return 'Choisissez votre lieu de résidence';
                      //   }
                      //   return null;
                      // },
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      // onPressed: _submitForm,
                      onPressed: () {
                        setState(() {
                          isloading = true;
                        });
                        verifyPhoneNumber();
                        setState(() {
                          isloading = false;
                        });
                      },
                      child: const Text('Inscription'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 100, vertical: 18),
                        backgroundColor:
                            const Color.fromARGB(220, 35, 102, 195),
                        foregroundColor: Colors.white,
                        textStyle: const TextStyle(fontSize: 16),
                        shadowColor: Colors.black,
                        elevation: 20,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Si vous avez un compte ?",
                          style: TextStyle(fontSize: 15),
                        ),
                        TextButton(
                          onPressed: () {
                            Get.to(login());
                          },
                          child: const Text(
                            "Connexion",
                            style: TextStyle(
                              fontSize: 13,
                              color: Color.fromARGB(249, 58, 166, 237),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
