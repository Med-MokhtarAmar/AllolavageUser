import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Notification extends StatelessWidget {
  final String employeeName;
  final bool isAccepted;
  final String phoneNumber;

  Notification({
    required this.employeeName,
    required this.isAccepted,
    required this.phoneNumber,
  });

  void _callNumber(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      print('Impossible de lancer $phoneNumber');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.all(10),
      child: ListTile(
        title: Text(
          'Employé : $employeeName',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(isAccepted ? 'Accepté' : 'En attente'),
        trailing: ElevatedButton.icon(
          onPressed: () => _callNumber(phoneNumber),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(249, 58, 166, 237),
            foregroundColor: Colors.white,
          ),
          icon: const Icon(
            Icons.phone,
            size: 18,
            color: Color.fromARGB(255, 129, 1, 164),
          ),
          label: const Text(
            'Appel',
            style: TextStyle(
              color: Color.fromARGB(238, 129, 1, 164), // Violet color for the text
            ),
          ),
        ),
      ),
    );
  }
}

class NotificationExample extends StatelessWidget {
  const NotificationExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        backgroundColor: Colors.blueAccent,
      ),
      body: ListView(
        children: [
          Notification(
            employeeName: 'Amar',
            isAccepted: true,
            phoneNumber: '48682847',
          ),
          Notification(
            employeeName: 'Ali',
            isAccepted: false,
            phoneNumber: '48682848',
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: NotificationExample(),
  ));
}
