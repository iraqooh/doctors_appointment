import 'package:doctors_appointment/components/widgets.dart';
import 'package:doctors_appointment/constants/strings.dart';
import 'package:doctors_appointment/models/users.dart';
import 'package:doctors_appointment/pages/root_page.dart';
import 'package:doctors_appointment/pages/signup_page.dart';
import 'package:doctors_appointment/utilities/providers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/compound_data.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isConnecting = false, obscured = true;

  @override
  void initState() {
    super.initState();
    initialize();
  }

  void initialize() async {

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Your Logo Image
            Image.asset(
              logo, // Replace with your logo image path
              height: 100,
            ),
            SizedBox(height: 20),
            // Email TextField
            TextField(
              controller: inputControllers['email'],
              decoration: InputDecoration(
                labelText: 'Email',
                icon: Icon(Icons.email),
              ),
            ),
            SizedBox(height: 20),
            // Password TextField
            TextField(
              controller: inputControllers['password'],
              obscureText: obscured,
              decoration: InputDecoration(
                labelText: 'Password',
                icon: Icon(Icons.lock),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      obscured = !obscured;
                    });
                  },
                  icon: Icon(
                    obscured ? Icons.visibility : Icons.visibility_off
                  ),
                )
              ),
            ),
            SizedBox(height: 20),
            // Login Button
            ElevatedButton(
              onPressed: () async {
                String email = inputControllers['email']!.text;
                String password = inputControllers['password']!.text;
                print(email + ' ' + password);
                setState(() {
                  isConnecting = true;
                });
                User? user = await UserService().login(email, password);
                UserModel? currentUser = await UserService().getUser();
                final prefs = await SharedPreferences.getInstance();
                if (currentUser != null) prefs.setBool('isDoctor', currentUser.isDoctor!);
                setState(() {
                  isConnecting = false;
                });
                if (user == null) {
                  Util.toast('Error logging in!');
                  return;
                }
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) =>
                      RootPage(currentUser: currentUser!, isDoctor: currentUser.isDoctor)
                  )
                );
              },
              child: isConnecting ? progressIndicator() : Text('Login'),
            ),
            SizedBox(height: 10),
            // Don't have an account? Sign up button
            TextButton(
              onPressed: () {
                // Navigate to the sign-up page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignupPage()),
                );
              },
              child: Text("Don't have an account? Sign up"),
            ),
          ],
        ),
      ),
    );
  }
}
