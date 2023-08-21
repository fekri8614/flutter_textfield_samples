/// https://docs.flutter.dev/cookbook/design/snackbars

import 'package:flutter/material.dart';

class SnackBarSample extends StatelessWidget {
  const SnackBarSample({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          final snackBar = SnackBar(
            content: const Text('Yay! A SnackBar!'),
            action: SnackBarAction(
              label: 'Undo',
              onPressed: () {
                // Some code
              },
            ),
          );

          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },
        child: const Text('Show Snackbar!'),
      ),
    );
  }
}
