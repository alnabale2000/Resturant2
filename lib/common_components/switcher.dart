import 'package:flutter/material.dart';

class AlreadyHaveAnAccountCheck extends StatelessWidget {
  final bool login;
  final Function press;
  const AlreadyHaveAnAccountCheck({
    Key key,
    this.login = true,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            login ? ' انشئ حساب  ' : ' لديك حساب بالفعل ؟ ',
            style: TextStyle(
              color: Colors.deepOrange[400],
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          Text(
            login ? ' ليس لديك حساب ؟ ' : ' تسجيل دخول ',
            style: TextStyle(color: Colors.deepOrange[400], fontSize: 18),
          ),
        ],
      ),
    );
  }
}
