import 'package:allolavage/screens/auth/login.dart';
import 'package:allolavage/servicesControllers/serviceController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'notification.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({Key? key}) : super(key: key);
  final Servicecontroller controller = Get.put(Servicecontroller());

  void logout() {
    controller.deleteFromPreferences();
    Get.offAll(() => login());
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          width: size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.blueAccent,
                    width: 5.0,
                  ),
                ),
                child: const CircleAvatar(
                  radius: 60,
                  backgroundImage: ExactAssetImage('images/assets/logo.png'),
                ),
              ),
              const SizedBox(height: 20),
              Column(
                children: [
                  Text(
                    "${controller.userName ?? " "}",
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '${controller.userAdress ?? " "}',
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '${controller.userPhone ?? " "}',
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: size.width * 0.9,
                child: Column(
                  children: [
                    ProfileOption(
                      icon: Icons.language,
                      title: 'Language',
                      onTap: () => _showLanguageSelector(context),
                    ),
                    const ProfileOption(
                      icon: Icons.notifications,
                      title: 'Notifications',
                      // onTap: () => Get.to(() => NotificationExample()),
                    ),
                    const ProfileOption(
                      icon: Icons.share,
                      title: 'Partager',
                    ),
                    InkWell(
                      onTap: () {
                        logout();
                      },
                      child: const ProfileOption(
                        icon: Icons.logout,
                        title: 'Déconnexion',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Fonction pour afficher le sélecteur de langue
  void _showLanguageSelector(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 10),
            const Text(
              'Sélectionnez la langue',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.language, color: Colors.blueAccent),
              title: const Text('Anglais'),
              onTap: () {
                _changeLanguage(context, 'en');
              },
            ),
            ListTile(
              leading: const Icon(Icons.language,
                  color: Color.fromARGB(238, 129, 1, 164)),
              title: const Text('Français'),
              onTap: () {
                _changeLanguage(context, 'fr');
              },
            ),
            ListTile(
              leading: const Icon(Icons.language, color: Colors.green),
              title: const Text('العربية'),
              onTap: () {
                _changeLanguage(context, 'ar');
              },
            ),
            const SizedBox(height: 20),
          ],
        );
      },
    );
  }

  // Fonction pour changer la langue
  void _changeLanguage(BuildContext context, String languageCode) {
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Langue modifiée en ${languageCode.toUpperCase()}'),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}

class ProfileOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback? onTap;

  const ProfileOption(
      {required this.icon, required this.title, this.onTap, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.blueAccent,
              size: 28,
            ),
            const SizedBox(width: 16),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
