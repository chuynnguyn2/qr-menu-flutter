import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {
  const ErrorDialog({Key? key, this.message}) : super(key: key);
  final String? message;


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      key: key,
      content: Text(message!),
      actions: [
        ElevatedButton(
          child: const Text("OK"),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
