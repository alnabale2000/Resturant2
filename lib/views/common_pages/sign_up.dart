import 'package:flutter/material.dart';
import 'package:resturant/common_components/input_field.dart';
import 'package:resturant/common_components/loading.dart';
import 'package:resturant/common_components/rounded_button.dart';
import 'package:resturant/common_components/switcher.dart';
import 'package:resturant/firebase/auth.dart';
import 'package:resturant/views/common_pages/log_in.dart';
import 'package:resturant/views/user_pages/user_home_page.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String email;
  String password;
  String username;
  String error = '';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: loading
          ? Loading()
          : Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: Colors.white,
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.green,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              body: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 80),
                        Text(
                          'Sign Up',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                            fontSize: 27.5,
                          ),
                        ),
                        SizedBox(height: 65),
                        RoundedInputField(
                          validator: (String val) =>
                              val.isEmpty ? 'ادخل اسم المستخدم' : null,
                          hintText: 'اسم المستخدم',
                          icon: Icons.account_box_outlined,
                          color: Colors.green,
                          onChanged: (val) {
                            username = val;
                          },
                        ),
                        RoundedInputField(
                          validator: (String val) =>
                              val.isEmpty ? 'ادخل بريدك الالكتروني' : null,
                          hintText: 'البريد الالكتروني',
                          icon: Icons.email_outlined,
                          color: Colors.green,
                          onChanged: (val) {
                            email = val;
                          },
                        ),
                        RoundedInputField(
                          validator: (String val) =>
                              val.length < 6 ? 'ادخل رقم بـ +6 خانات' : null,
                          hintText: 'الرقم السري',
                          isPass: true,
                          icon: Icons.lock_open_outlined,
                          color: Colors.green,
                          onChanged: (val) {
                            password = val;
                          },
                        ),
                        Padding(
                          padding: error == ''
                              ? const EdgeInsets.all(0)
                              : const EdgeInsets.all(8.0),
                          child: Text(
                            error ?? '',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: error == '' ? 0 : 20,
                            ),
                          ),
                        ),
                        RoundedButton(
                          text: 'CONFIRM',
                          color: Colors.green,
                          press: () async {
                            if (_formKey.currentState.validate()) {
                              setState(() {
                                loading = true;
                              });
                              dynamic result = await Auth().regWithEmailAndPass(
                                  email, password, username);
                              if (result != null) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => UserHomePage()));
                              } else {
                                setState(() {
                                  error = 'ايميل غير صحيح';
                                  loading = false;
                                });
                              }
                            }
                          },
                        ),
                        SizedBox(height: 30)
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
