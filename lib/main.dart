import 'package:flutter/material.dart';
import 'package:ostad_assignment_flutter_3/image_list_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Module 12 - Assignment',
      home: ImageListScreen(),
    );
  }
}

