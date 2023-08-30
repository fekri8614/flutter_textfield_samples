import 'package:flutter/material.dart';
import 'classes/animations/misc/expand_card.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ExpandCardDemo(), // replace it
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

// https://github.com/flutter/samples/tree/main/animations/lib/src/misc
