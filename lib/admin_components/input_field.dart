import 'package:flutter/material.dart';
import 'package:resturant/admin_components/text_field.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  final Function validator;
  final Color color;
  final bool isNumber;
  final bool isMultiLine;
  final Color backGroundColor;

  const RoundedInputField({
    Key key,
    this.hintText,
    this.icon,
    this.onChanged,
    this.validator,
    this.color,
    this.backGroundColor,
    this.isNumber = false,
    this.isMultiLine = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      color: backGroundColor,
      child: TextFormField(
        keyboardType: isMultiLine
            ? TextInputType.multiline
            : isNumber
                ? TextInputType.number
                : TextInputType.text,
        minLines: 1,
        maxLines: 6,
        validator: validator,
        onChanged: onChanged,
        cursorColor: color,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: color,
          ),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
