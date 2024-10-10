// ignore: file_names
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geeksynergy/screen/loginScreen.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

import 'package:shared_preferences/shared_preferences.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();

  // Text controllers for each field
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordController2 = TextEditingController();

  bool obscureText = false;
  bool obscureText1 = false;

  // Profession dropdown values
  final List<String> _professions = [
    'Student',
    'Engineer',
    'Doctor',
    'Artist',
    'Other'
  ];
  String? _selectedProfession;

  // Save user details in SharedPreferences

  Future<void> saveUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Save user data in shared preferences
    await prefs.setString('name', nameController.text);
    await prefs.setString('email', emailController.text);
    await prefs.setString('phone', phoneController.text);
    await prefs.setString('profession', _selectedProfession ?? 'Other');
    await prefs.setString(
        'password', passwordController.text); // Save the password
    await prefs.setBool("accountStatus", false); // Track login status

    // Log the data being saved
    log("User Data Saved:");
    log("Name: ${nameController.text}");
    log("Email: ${emailController.text}");
    log("Phone: ${phoneController.text}");
    log("Profession: ${_selectedProfession ?? 'Other'}");
    log("Password: ${passwordController.text}"); // Be cautious about logging passwords

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("User account created successfully!")),
    );

    // Navigate to the login screen

    Get.to(() => const LoginScreen());
    // EasyLoading.showSuccess("User account created successfully!");
  }

  // Check if passwords match
  bool passwordConfirmed() {
    return passwordController.text.trim() == passwordController2.text.trim();
  }

  @override
  void dispose() {
    // Clear all text fields on dispose
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    passwordController2.dispose();
    super.dispose();
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
                const SizedBox(height: 50),
                const Text(
                  "CREATE A NEW ACCOUNT",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Few More Steps To Your Account",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 20),

                // Form with all the fields
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
                      const SizedBox(height: 15),

                      // Email Field
                      TextFormField(
                        controller: emailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter your email";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: "Email",
                          prefixIcon:
                              const Icon(Icons.email, color: Colors.grey),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade400),
                          ),
                          fillColor: Colors.grey[200],
                          filled: true,
                        ),
                      ),
                      const SizedBox(height: 15),

                      // Phone Number Field
                      TextFormField(
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value.length < 10) {
                            return "Please enter a valid phone number";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: "Phone Number",
                          prefixIcon:
                              const Icon(Icons.phone, color: Colors.grey),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade400),
                          ),
                          fillColor: Colors.grey[200],
                          filled: true,
                        ),
                      ),
                      const SizedBox(height: 15),

                      // Profession Dropdown
                      DropdownButtonFormField<String>(
                        value: _selectedProfession,
                        items: _professions
                            .map((profession) => DropdownMenuItem<String>(
                                  value: profession,
                                  child: Text(profession),
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedProfession = value;
                          });
                        },
                        decoration: InputDecoration(
                          labelText: "Profession",
                          prefixIcon:
                              const Icon(Icons.work, color: Colors.grey),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade400),
                          ),
                          fillColor: Colors.grey[200],
                          filled: true,
                        ),
                        validator: (value) =>
                            value == null ? 'Please select a profession' : null,
                      ),
                      const SizedBox(height: 15),

                      // Password Field
                      TextFormField(
                        controller: passwordController,
                        obscureText: !obscureText,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter a password";
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
                      const SizedBox(height: 15),

                      // Confirm Password Field
                      TextFormField(
                        controller: passwordController2,
                        obscureText: !obscureText1,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please confirm your password";
                          } else if (!passwordConfirmed()) {
                            return "Passwords do not match";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: "Confirm Password",
                          prefixIcon:
                              const Icon(Icons.lock, color: Colors.grey),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade400),
                          ),
                          fillColor: Colors.grey[200],
                          filled: true,
                          suffixIcon: IconButton(
                            icon: Icon(
                              obscureText1
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                obscureText1 = !obscureText1;
                              });
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 25),

                      // Sign Up Button
                      SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              await saveUser(); // Save user data if form is valid
                            }
                          },
                          style: const ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.black)),
                          child: const Text(
                            "SIGN UP",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 50),

                // Already have an account? Sign in link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "If You Already Have An Account? -",
                      style: TextStyle(
                        color: Colors.grey[700],
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        // Navigate to login screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()),
                        );
                      },
                      child: const Text(
                        "Sign in",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
