import 'package:first_flutter_vscode/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'create_account_screen.dart';
import 'home/home_screen.dart'; 
import 'package:get/get.dart';

class login extends StatefulWidget {
  @override
  _login createState() => _login();
}

class _login extends State<login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? phoneNumber;
   

  @override
  Widget build(BuildContext context) {
    const titleStyle = TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(220, 35, 102, 195),
        shadowColor: const Color.fromARGB(255, 0, 0, 0),
        elevation: 10,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey, // Utiliser le Form avec la clé
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                Image.asset(
                  'images/logo.png',
                  height: 150,
                  width: 150,
                  fit: BoxFit.cover,
                ),
                const Center(
                  child: Text(
                    'Bienvenue !',
                    style: titleStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 30),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Numéro de téléphone',
                    prefixIcon: Icon(Icons.phone, color: Color.fromARGB(238, 129, 1, 164)),
                  ),
                  keyboardType: TextInputType.phone,
                  maxLength: 8,
                  validator: (value) {
                    if (value == null || value.isEmpty || value.length != 8) {
                      return 'Entrez un numéro de téléphone valide de 8 chiffres';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      phoneNumber = value; 
                    });
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      List<String> existingPhoneNumbers = ['01234567', '07654321']; 
                      
                      if (existingPhoneNumbers.contains(phoneNumber)) {
                        Get.to(HomeScreen());
                        Get.to(MainScreen());
                  
                      } else {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                               title: Center(
                                child: Text(
                                  'Erreur',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).colorScheme.error, 
                                  ),
                                ),
                              ),
                              content: const Text('Ce numéro de téléphone n\'est pas enregistré.'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(); 
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    }
                  },
                  child: const Text('Se connecter'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(220, 35, 102, 195),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 18),
                    textStyle: const TextStyle(fontSize: 16),
                    shadowColor: Colors.black,
                    elevation: 15,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),  
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Si vous n'avez pas de compte ?",
                      style: TextStyle(fontSize: 15),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.to(() =>  CreateAccountScreen());
                      },
                      child: const Text(
                        "Inscription",
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
      ),
    );
  }
}
