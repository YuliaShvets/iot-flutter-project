import 'package:flutter/material.dart';

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({Key? key});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;

    // Define constants for responsive adjustments
    final double textFieldPadding = screenWidth * 0.1;
    final double verticalSpacing = screenWidth * 0.05;
    final double buttonPadding = screenWidth * 0.1;

    return Scaffold(
      appBar: AppBar(title: const Text('Registration')),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1), // Adjust horizontal padding
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: verticalSpacing),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: verticalSpacing),
            TextFormField(
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: verticalSpacing),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: buttonPadding),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/home');
                },
                child: const Text('Register'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
