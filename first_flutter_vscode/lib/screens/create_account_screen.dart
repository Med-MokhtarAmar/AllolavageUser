import 'package:flutter/material.dart';
import 'main_screen.dart'; 
import 'page/profile_screen.dart'; 
import 'login.dart'; 
import 'package:get/get.dart';

class CreateAccountScreen extends StatefulWidget {
  @override
  _CreateAccountScreenState createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String phoneNumber = '';
  String address = '';

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Get.to(() => const ProfilePage());
      Get.to(() =>  MainScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Créer un compte', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromARGB(220, 35, 102, 195),
        shadowColor: const Color.fromARGB(255, 0, 0, 0),
        elevation: 10,
        
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 20),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Nom Personnel',
                  prefixIcon: Icon(Icons.person, color: Color.fromARGB(238, 129, 1, 164)),
                ),
                // validator: (value) {
                //   if (value!.isEmpty) {
                //     return 'Entrez le nom personnel';
                //   }
                //   return null;
                // },
                // onSaved: (value) {
                //   name = value!;
                // },
              ),
              const SizedBox(height: 20),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Numéro de téléphone',
                  prefixIcon: Icon(Icons.phone, color: Color.fromARGB(238, 129, 1, 164)),
                ),
                keyboardType: TextInputType.phone,
                maxLength: 8,
                // validator: (value) {
                //   if (value!.isEmpty || value.length != 8) {
                //     return 'Entrez un numéro de téléphone valide de 8 chiffres';
                //   }
                //   return null;
                // },
                // onSaved: (value) {
                //   phoneNumber = value!;
                // },
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Lieu de résidence',
                  prefixIcon: Icon(Icons.location_on, color: Color.fromARGB(238, 129, 1, 164)),
                ),
                items: const [
                  DropdownMenuItem(value: 'ayn talh', child: Text('ayn talh')),
                  DropdownMenuItem(value: 'gedroh nuadibou', child: Text('gedroh nuadibou')),
                  DropdownMenuItem(value: 'center metér', child: Text('center metér')),
                  DropdownMenuItem(value: 'sahrawi', child: Text('sahrawi')),
                  DropdownMenuItem(value: 'soucoucou', child: Text('soucoucou')),
                ],
                onChanged: (value) {
                  setState(() {
                    address = value!;
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
                onPressed: _submitForm,
                child: const Text('Inscription'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 18),
                  backgroundColor: const Color.fromARGB(220, 35, 102, 195),
                  foregroundColor: Colors.white,
                  textStyle: const TextStyle(fontSize: 16),
                  shadowColor: Colors.black,
                  elevation: 20,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),

               SizedBox(height: 10),
           
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
