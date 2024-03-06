import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenHeight = screenSize.height;
    final double screenWidth = screenSize.width;

    // Define constants for responsive adjustments
    final double avatarRadius = screenHeight * 0.08;
    final double userNameFontSize = screenWidth * 0.06;
    final double emailFontSize = screenWidth * 0.045;
    final double buttonPaddingVertical = screenHeight * 0.04;

    return Scaffold(
      appBar: AppBar(title: const Text('User Profile')),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: avatarRadius,
                backgroundColor: Colors.blue,
                child: Icon(
                  Icons.person,
                  size: avatarRadius * 0.8,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: screenHeight * 0.05),
              Text(
                'Yulia Shvets',
                style: TextStyle(
                  fontSize: userNameFontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              Text(
                'yuliia.shvets04@gmail.com',
                style: TextStyle(
                  fontSize: emailFontSize,
                ),
              ),
              SizedBox(height: screenHeight * 0.05),
              Padding(
                padding: EdgeInsets.symmetric(vertical: buttonPaddingVertical),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
                  },
                  child: const Text('Logout'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
