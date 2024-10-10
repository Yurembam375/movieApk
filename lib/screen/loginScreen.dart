
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:geeksynergy/screen/homeScreen.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';

// The Login Screen Class
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  // Text controllers for login fields
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  bool obscureText = true;

  @override
  void dispose() {
    nameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> validateLogin() async {
    // Retrieve shared preferences instance
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Fetch the stored credentials from SharedPreferences
    String? storedName = prefs.getString('name');
    String? storedPassword = prefs.getString('password');

    // Log the values to ensure they are not null
    log('Stored Name: $storedName');
    log('Stored Password: $storedPassword');

    // Log the entered values to check if they are being entered correctly
    log('Entered Name: ${nameController.text.trim()}');
    log('Entered Password: ${passwordController.text.trim()}');

    // Ensure that stored credentials are not null and entered values are not empty
    if (storedName != null &&
        storedPassword != null &&
        nameController.text.trim().isNotEmpty &&
        passwordController.text.trim().isNotEmpty) {
      
      // Compare trimmed and lowercased values to handle potential case sensitivity or whitespace issues
      if (nameController.text.trim().toLowerCase() == storedName.trim().toLowerCase() &&
          passwordController.text.trim() == storedPassword.trim()) {
        log("Login Successful");

        // Navigate to HomeScreen using GetX
        Get.to(() => HomeScreen());
      } else {
        log("Invalid Credentials");
        Get.snackbar("Error", "Invalid Credentials",
            snackPosition: SnackPosition.BOTTOM);
      }
    } else {
      log("No account found or Empty fields");
      Get.snackbar("Error", "No account found or Empty fields",
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 100),
                const Text(
                  "LOGIN TO YOUR ACCOUNT",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Enter your credentials to continue",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 40),

                // Login Form
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // Name Field
                      TextFormField(
                        controller: nameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter your name";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: "Name",
                          prefixIcon:
                              const Icon(Icons.person, color: Colors.grey),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade400),
                          ),
                          fillColor: Colors.grey[200],
                          filled: true,
                        ),
                      ),
                      const SizedBox(height: 25),

                      // Password Field
                      TextFormField(
                        controller: passwordController,
                        obscureText: obscureText,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter your password";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: "Password",
                          prefixIcon:
                              const Icon(Icons.lock, color: Colors.grey),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade400),
                          ),
                          fillColor: Colors.grey[200],
                          filled: true,
                          suffixIcon: IconButton(
                            icon: Icon(
                              obscureText
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                obscureText = !obscureText;
                              });
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),

                      // Login Button
                      SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            // Call validateLogin() when the user taps the Login button
                            if (_formKey.currentState!.validate()) {
                              await validateLogin();
                            }
                          },
                          style: const ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.black),
                          ),
                          child: const Text(
                            "LOGIN",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 50),

                // Don't have an account? Sign up link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account? -",
                      style: TextStyle(
                        color: Colors.grey[700],
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        // Navigate to signup screen
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
