import 'package:flutter/material.dart';

class RetrieveTextInput extends StatefulWidget {
  const RetrieveTextInput({super.key});

  @override
  State<RetrieveTextInput> createState() => _RetrieveTextInputState();
}

class _RetrieveTextInputState extends State<RetrieveTextInput> {
  final myController = TextEditingController();

  @override
  void initState() {
    super.initState();

    myController.addListener(_printLatestValue);
  }

  @override
  void dispose() {
    myController.dispose();

    super.dispose();
  }

  void _printLatestValue() {
    final text = myController.text;
    print('Second TextField: $text (${text.characters.length})');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              onChanged: (text) {
                print('First text field: $text (${text.characters.length})');
              },
            ),
            TextField(
              controller: myController,
            ),
          ],
        ),
      ),
    );
  }
}
