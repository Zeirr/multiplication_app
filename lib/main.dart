import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MultiplicationApp());
}

class MultiplicationApp extends StatelessWidget {
  const MultiplicationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tables de multiplication',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
