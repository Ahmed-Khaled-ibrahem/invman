import 'package:flutter/material.dart';
import 'package:invman/presentation/layout/home_screen.dart';


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
      theme: ThemeData(
        primarySwatch: Colors.blue,
        elevatedButtonTheme: const ElevatedButtonThemeData(
          style: ButtonStyle(
          )
        )
      ),
      home:  const HomeScreen(),
    );
  }
}
