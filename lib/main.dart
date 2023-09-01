import 'package:flutter/material.dart';
import 'package:flutter_application_api1/login.dart';
import 'package:flutter_application_api1/theme/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      theme: AppTheme.lightTheme,
      home: const Login(),
    );
  }
}

