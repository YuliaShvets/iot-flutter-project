import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;

    // Define constants for responsive adjustments
    final double logoHeight = screenWidth * 0.2;
    final double verticalSpacing = screenWidth * 0.05;
    final double buttonPadding = screenWidth * 0.1;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1), // Adjust horizontal padding
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              child: Image.asset(
                'assets/image.png', // Change the path to your logo image
                height: logoHeight,
              ),
            ),
            // Email field
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: verticalSpacing),
            // Password field
            TextFormField(
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: verticalSpacing),
            // Login button
            Padding(
              padding: EdgeInsets.symmetric(horizontal: buttonPadding),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/home');
                },
                child: const Text('Login'),
              ),
            ),
            const SizedBox(height: 10),
            // Registration button
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/registration');
              },
              child: const Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
