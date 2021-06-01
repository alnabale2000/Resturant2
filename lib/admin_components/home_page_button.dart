import 'package:flutter/material.dart';

class AdminButton extends StatelessWidget {
  final String text;
  final Function function;

  AdminButton({this.text, this.function});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(4, 18, 4, 18),
        child: TextButton(
          child: Card(
            color: Colors.green,
            child: Center(
              child: Text(
                text,
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
          onPressed: function,
        ),
      ),
    );
  }
}
