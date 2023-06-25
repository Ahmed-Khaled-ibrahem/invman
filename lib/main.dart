import 'package:flutter/material.dart';
import 'package:invman/presentation/layout/home_screen.dart';
import 'package:invman/presentation/theme/theme.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Freelancer',
      theme: lightTheme,
      home:  const HomeScreen(),
    );
  }
}
