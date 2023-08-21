import 'package:flutter/material.dart';

class MyFocusedTextField extends StatefulWidget {
  const MyFocusedTextField({super.key});

  @override
  State<MyFocusedTextField> createState() => _MyFocusedTextFieldState();
}

class _MyFocusedTextFieldState extends State<MyFocusedTextField> {
  late FocusNode myFocuseNode;

  @override
  void initState() {
    super.initState();

    myFocuseNode = FocusNode();
  }

  @override
  void dispose() {
    myFocuseNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const TextField(autofocus: true),
            TextField(focusNode: myFocuseNode),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => myFocuseNode.requestFocus(),
        tooltip: 'Focus Second Text Field',
        child: const Icon(Icons.edit),
      ),
    );
  }
}
