import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'ConfirmationScreen.dart';
import 'car_screen.dart';

class WashScreen extends StatefulWidget {
  final String matricule;
  final String nom;
  final String tel;
  final String taille;

  const WashScreen({super.key, required this.matricule, required this.nom, required this.tel, required this.taille});
  
  @override
  _WashScreenState createState() => _WashScreenState();
}

class _WashScreenState extends State<WashScreen> {
  bool sans_brosage = false;
  bool avec_brosage = false;
  bool brosage1 = false;
  bool brosage2 = false;

  final _formKey = GlobalKey<FormState>();
  String _selectedDate = '';
  String? _selectedTime;
  String address = '';

  // Déclaration des variables pour les informations de la voiture
  String _carName = '';
  String _carSize = ''; 
  String _registration = '';
  String _bookingTime = '';

  final List<String> _timeOptions = [
    '08:00', '08:30', '09:00', '09:30', '10:00', '10:30', '11:00', '11:30',
    '12:00', '12:30', '13:00', '13:30', '14:00', '14:30', '15:00', '15:30',
    '16:00', '16:30', '17:00', '17:30', '18:00', '18:30',
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
      if (!avec_brosage && !sans_brosage) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Veuillez sélectionner au moins un service de lavage.'),
            duration: Duration(seconds: 2),
          ),
        );
        return; // Quittez la fonction si aucun service n'est sélectionné
      }

      _formKey.currentState!.save();
      _carName = widget.nom; // Assignez le nom de la voiture
      _carSize = widget.taille;
      _registration = widget.matricule; // Utilisez le matricule
      _bookingTime = '$_selectedDate $_selectedTime'; // Combinez la date et l'heure

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ConfirmationScreen(
            carName: _carName,
            carSize: _carSize,
            registration: _registration,
            bookingTime: _bookingTime,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lavage'),
        backgroundColor: const Color.fromARGB(220, 35, 102, 195),
        shadowColor: Colors.black,
        elevation: 10,
        titleTextStyle: TextStyle(color: Color(0xF1FFFFFF), fontSize: 18),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xF1FFFFFF)),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CarScreen()),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    title: Text(
                      '${widget.nom}',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      '${widget.matricule}',
                      style: TextStyle(fontSize: 14, color: Colors.green),
                    ),
                    trailing: Text(
                      '${widget.tel}',
                      style: TextStyle(fontSize: 14, color: Color.fromARGB(238, 129, 1, 164)),
                    ),
                    leading: Icon(Icons.directions_car, color: Color.fromARGB(238, 129, 1, 164)),
                ),
                ),
                SizedBox(height: 10), 

                Row(
                  children: [
                    Icon(Icons.local_car_wash, color: const Color.fromARGB(220, 35, 102, 195), size: 20),
                    SizedBox(width: 8),
                    Text(
                      'Principales Prestations',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),

                ListView(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    Card(
                      elevation: 5,
                      child: ListTile(
                        leading: Icon(Icons.cleaning_services, color: Color.fromARGB(238, 129, 1, 164)),
                        title: Text(
                          'Service de lavage avec brossage',
                          style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          'Prix: 50 \$',
                          style: TextStyle(color: Colors.green, fontSize: 12.0),
                        ),
                        trailing: Checkbox(
                          value: avec_brosage,
                          onChanged: (bool? value) {
                            setState(() {
                              avec_brosage = value ?? false;
                              if (avec_brosage) sans_brosage = false;
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 10),

                    Card(
                      elevation: 5,
                      child: ListTile(
                        leading: Icon(Icons.bubble_chart, color: Color.fromARGB(238, 129, 1, 164)),
                        title: Text(
                          'Service de lavage sans brossage',
                          style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          'Prix: 30 \$',
                          style: TextStyle(color: Colors.green, fontSize: 12.0),
                        ),
                        trailing: Checkbox(
                          value: sans_brosage,
                          onChanged: (bool? value) {
                            setState(() {
                              sans_brosage = value ?? false;
                              if (sans_brosage) avec_brosage = false;
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 10),

                    Row(
                      children: [
                        Icon(Icons.clean_hands, color: const Color.fromARGB(220, 35, 102, 195), size: 20),
                        SizedBox(width: 8),
                        Text(
                          'Prestations Supplémentaires',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),

                    Card(
                      elevation: 5,
                      child: ListTile(
                        leading: Icon(Icons.format_paint, color: Color.fromARGB(238, 129, 1, 164)),
                        title: Text(
                          'Suppression des rayures',
                          style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          'Prix: 50 \$',
                          style: TextStyle(color: Colors.green, fontSize: 12.0),
                        ),
                        trailing: Checkbox(
                          value: brosage1,
                          onChanged: (bool? value) {
                            setState(() {
                              brosage1 = value ?? false;
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 10),

                    Card(
                      elevation: 5,
                      child: ListTile(
                        leading: Icon(Icons.build_circle, color: Color.fromARGB(238, 129, 1, 164)),
                        title: Text(
                          'Vidange',
                          style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          'Prix: 30 \$',
                          style: TextStyle(color: Colors.green, fontSize: 12.0),
                        ),
                        trailing: Checkbox(
                          value: brosage2,
                          onChanged: (bool? value) {
                            setState(() {
                              brosage2 = value ?? false;
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 10),

                      TextFormField(
                      readOnly: true,
                      onTap: () => _selectDate(context),
                      decoration: InputDecoration(
                        labelText: 'Date de lavage',
                        labelStyle: TextStyle(color: const Color.fromARGB(255, 81, 80, 80)),
                        prefixIcon: Icon(Icons.calendar_today, color: Color.fromARGB(238, 129, 1, 164)),
                      ),
                      controller: TextEditingController(text: _selectedDate),
                      validator: (value) {
                        if (_selectedDate.isEmpty) {
                          return 'Veuillez sélectionner une date';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),

                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: 'Heure de lavage',
                        labelStyle: TextStyle(color: const Color.fromARGB(255, 81, 80, 80)),
                        prefixIcon: Icon(Icons.access_time, color: Color.fromARGB(238, 129, 1, 164)),
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

                    // Ajoutez le champ pour l'adresse
                    SizedBox(height: 10),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Adresse',
                        labelStyle: TextStyle(color: const Color.fromARGB(255, 81, 80, 80)),
                        prefixIcon: Icon(Icons.location_on, color: Color.fromARGB(238, 129, 1, 164)),
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
                  ],
                ),
                
                SizedBox(height: 15),
                
                ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 85, vertical: 17),
                    backgroundColor: Color.fromARGB(220, 35, 102, 195),
                  ),
                  child: Text('Confirmer le lavage', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
