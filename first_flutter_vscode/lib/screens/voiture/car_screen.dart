import 'package:flutter/material.dart';
import '../home/home_screen.dart';
// import 'package:intl/intl.dart';
// import 'ConfirmationScreen.dart';
// import 'main_screen.dart';
import 'wash_screen.dart';

class CarScreen extends StatefulWidget {
  @override
  _CarScreenState createState() => _CarScreenState();
}

class _CarScreenState extends State<CarScreen> {
  final _formKey = GlobalKey<FormState>();

  List<Map<String, String>> carList = [ ];

  String carName = '';
  String carSize = 'Milieu';
  String carPlate = '';
  String phoneNumber = '';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ma Voiture'),
        backgroundColor:  Color.fromARGB(220, 35, 102, 195),
        shadowColor: Colors.black,
        elevation: 10,
        titleTextStyle: TextStyle(color: Color(0xF1FFFFFF), fontSize: 18),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xF1FFFFFF)),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          },
        ),
      ),

      body: Column( 
        children: [
          SizedBox(height: 20), 
          Expanded(
            child: carList.isEmpty
                ? Center(child: Text('Aucune voiture ajoutée'))
                : ListView.builder(
                    itemCount: carList.length,
                    itemBuilder: (context, index) {
                      final car = carList[index];

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => WashScreen(nom: car['name'] ?? '',
                            matricule:car['plate']?? '' ,tel: car['phone'] ?? '' , taille: car['size'] ?? '')),
                            
                          );
                        },
                        
                        child: Card(
                          color: Color.fromARGB(255, 239, 239, 249),
                          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.blueAccent,
                              child: Text(car['size']![0],style: TextStyle(color: Color.fromARGB(238, 129, 1, 164))), // Première lettre de la taille
                            ),
                            title: Text(car['name'] ?? '',style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold,
                            ), ),
                            subtitle: Text(car['plate'] ?? '',style: TextStyle(color: Colors.green),),
                            trailing: Text(car['phone'] ?? '',style: TextStyle(color: Color.fromARGB(238, 129, 1, 164))),
                          ),
                        ),
                      );
                    },
                  ),
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
                  title: Text(
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
                            decoration: InputDecoration(
                              labelText: 'Numéro de téléphone',
                              prefixIcon: Icon(
                                Icons.phone,
                                color: Color.fromARGB(238, 129, 1, 164),
                              ),
                            ),
                            keyboardType: TextInputType.phone,
                            maxLength: 8,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value!.isEmpty || value.length != 8) {
                                return 'Entrez un numéro de téléphone';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              phoneNumber = value!;
                            },
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Nom de la voiture',
                              prefixIcon: Icon(
                                Icons.directions_car,
                                color: Color.fromARGB(238, 129, 1, 164),
                              ),
                            ),
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Veuillez entrer le nom de la voiture';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              carName = value!;
                            },
                          ),
                          SizedBox(height: 20),
                          DropdownButtonFormField<String>(
                            value: carSize,
                            items: ['Grand', 'Milieu', 'Petit']
                                .map((size) => DropdownMenuItem(
                                      value: size,
                                      child: Text(size),
                                    ))
                                .toList(),
                            decoration: InputDecoration(
                              labelText: 'Taille de la voiture',
                              prefixIcon: Icon(
                                Icons.height,
                                size: 20.0,
                                color: Color.fromARGB(238, 129, 1, 164),
                              ),
                            ),
                            onChanged: (value) {
                              carSize = value!;
                            },
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Matricule de la voiture',
                              prefixIcon: Icon(
                                Icons.confirmation_number,

                                color: Color.fromARGB(238, 129, 1, 164),
                              ),
                            ),
                            maxLength: 8,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value!.isEmpty || value.length != 8) {
                                return 'Entrez Matricule de la voiture';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              carPlate = value!;
                            },
                          ),
                          SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // Ferme la boîte de dialogue
                      },
                      child: Text('Annuler'),
                    ),
                    TextButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save(); // Sauvegarde les champs du formulaire

                          setState(() {
                            carList.add({
                              'name': carName,
                              'size': carSize,
                              'plate': carPlate,
                              'phone': phoneNumber,
                            });
                          });

                          Navigator.of(context).pop(); // Ferme la boîte de dialogue
                        }
                      },
                      child: Text('Enregistrer'),
                    ),
                  ],
                );
              },
            );
          },
          backgroundColor: const Color.fromRGBO(230, 222, 232, 1),
          child: Icon(Icons.add, color: Color.fromARGB(248, 194, 3, 247)),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}