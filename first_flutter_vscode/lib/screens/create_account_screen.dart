import 'package:flutter/material.dart';
import 'main_screen.dart';


class CreateAccountScreen extends StatefulWidget {
  @override
  _CreateAccountScreenState createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final _formKey = GlobalKey<FormState>();
  String phoneNumber = '';
  String carType = '';
  String carNumber = '';
  String address = '';

  void _submitForm() {
    // if (_formKey.currentState!.validate()) {
    //   _formKey.currentState!.save();
    //   Navigator.pushReplacement(
    //     context,
    //     MaterialPageRoute(builder: (context) => MainScreen()),
    //   );
    // }
          Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainScreen()),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Créer un compte',style: TextStyle(color: Colors.white)),
        backgroundColor: const  Color.fromARGB(220, 35, 102, 195),
        shadowColor: Colors.black,
        elevation: 10,
        leading: IconButton( // Utilisez 'leading' avec IconButton pour gérer le retour
        icon: Icon(Icons.arrow_back, color: Color(0xF1FFFFFF)),
        onPressed: () {
          Navigator.pop(context); // Retourne à l'écran précédent
        },
      ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [

              // SizedBox(height: 130),
              // Text('Créer un compte dans Allo lavage',style: TextStyle(fontSize: 18,
              //  color:Colors.black), 
              // ),

              SizedBox(height: 20),

              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                  labelText: 'Nom Personnel',
                  prefixIcon: Icon(Icons.person, color: Color.fromARGB(238, 129, 1, 164)),
                ),
                // validator: (value) {
                //   if (value!.isEmpty) {
                //     return 'Entrez le nom personnel';
                //   }
                //   return null;
                // },
                onSaved: (value) {
                  carType = value!;
                },
              ),
              SizedBox(height: 20),

              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
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
                onSaved: (value) {
                  phoneNumber = value!;
                },
              ),
              SizedBox(height: 20),
              
             DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: 'Lieu de résidence',
                          prefixIcon: Icon(Icons.location_on, color: Color.fromARGB(238, 129, 1, 164)),
                        ),
                        items: [
                          
                          DropdownMenuItem(value: 'ayn talh', child: Text('ayn talh')),
                          DropdownMenuItem(value: 'gedroh nuadibou', child: Text('gedroh nuadibou')),
                          DropdownMenuItem(value: 'center metér', child: Text('center metér')),
                          DropdownMenuItem(value: 'sahrawi', child: Text('sahrawi')),
                          DropdownMenuItem(value: 'soucoucou', child: Text('soucoucou')),
                        ],
                        onChanged: (value) {
                          // Logique lors de la sélection d'un élément (optionnel)
                        },
                        // validator: (value) {
                        //   if (value == null || value.isEmpty) {
                        //     return 'Choisissez un mode de paiement';
                        //   }
                        //   return null;
                        // },
                      ),
              // SizedBox(height: 20),
              // TextFormField(
              //   autovalidateMode: AutovalidateMode.onUserInteraction,
              //   decoration: InputDecoration(
              //     labelText: 'Adresse',
              //     prefixIcon: Icon(Icons.location_on, color: Color.fromARGB(238, 129, 1, 164)),
              //   ),
              //   validator: (value) {
              //     if (value!.isEmpty) {
              //       return 'Entrez une adresse';
              //     }
              //     return null;
              //   },
              //   onSaved: (value) {
              //     address = value!;
              //   },
              // ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Inscription'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 100, vertical: 18),
                  backgroundColor: const Color.fromARGB(220, 35, 102, 195),
                  foregroundColor: Colors.white,
                  textStyle: TextStyle(fontSize: 16),
                  shadowColor: Colors.black,
                  elevation: 20,
                  shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
