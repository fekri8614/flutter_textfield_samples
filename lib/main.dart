import 'package:flutter/material.dart';
import 'classes/custom_form.dart';
import 'classes/focused_textfield.dart';
import 'classes/retrieve_text_input.dart';
import 'classes/textfield_style.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Form Validation Demo';

    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(appTitle),
        ),
        body: const RetrieveTextInput(),
      ),
    );
  }
}
