import 'package:flutter/material.dart';

class AdminButton extends StatelessWidget {
  final String text;
  final Function function;

  AdminButton({this.text, this.function});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        child: Card(
          elevation: 15,
          color: Colors.white,
          child: Center(
            child: Text(
              text,
              style: TextStyle(color: Colors.green, fontSize: 20),
            ),
          ),
        ),
        onTap: function,
      ),
    );
  }
}
