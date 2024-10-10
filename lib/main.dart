import 'package:flutter/material.dart';
import 'package:geeksynergy/screen/homeScreen.dart';
import 'package:geeksynergy/screen/signupScreen.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(),
        home: const SignupScreen());
  }
}
