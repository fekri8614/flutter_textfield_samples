import 'package:flutter/material.dart';
import 'classes/retrieve_text_input.dart';
import 'design/order_food.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: ExampleDragAndDrop(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
