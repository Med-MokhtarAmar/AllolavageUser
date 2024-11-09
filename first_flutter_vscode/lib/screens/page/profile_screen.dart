import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          width: size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Profile Picture with Circular Border
              Container(
                width: 150,
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: const ExactAssetImage('assets/images/logo.png'), // Corrected path
                ),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.blueAccent, // Adjust border color as needed
                    width: 5.0,
                  ),
                ),
              ),
              
              const SizedBox(height: 10),
              
              // User Name with Verified Badge
              SizedBox(
                width: size.width * .5,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'John Doe',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Image.asset(
                      "assets/images/verified.png", // Path to verified badge image
                      width: 24,
                      height: 24,
                    ),
                  ],
                ),
              ),
              
              // Email Address
              const Text(
                'johndoe@gmail.com',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              
              const SizedBox(height: 30),
              
              // Profile Options
              SizedBox(
                width: size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ProfileWidget(
                      icon: Icons.person,
                      title: 'My Profile',
                    ),
                    ProfileWidget(
                      icon: Icons.settings,
                      title: 'Settings',
                    ),
                    ProfileWidget(
                      icon: Icons.notifications,
                      title: 'Notifications',
                    ),
                    ProfileWidget(
                      icon: Icons.chat,
                      title: 'FAQs',
                    ),
                    ProfileWidget(
                      icon: Icons.share,
                      title: 'Share',
                    ),
                    ProfileWidget(
                      icon: Icons.logout,
                      title: 'Log Out',
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
}

// Profile Widget for Each Option
class ProfileWidget extends StatelessWidget {
  final IconData icon;
  final String title;

  const ProfileWidget({
    Key? key,
    required this.icon,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(
            icon,
            size: 28,
            color: Colors.blueAccent, // Customize icon color
          ),
          const SizedBox(width: 20),
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
