import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resturant/common_components/input_field.dart';
import 'package:resturant/common_components/loading.dart';
import 'package:resturant/common_components/rounded_button.dart';
import 'package:resturant/common_components/switcher.dart';
import 'package:resturant/firebase/auth.dart';
import 'package:resturant/random_states.dart';
import 'package:resturant/views/common_pages/sign_up.dart';
import 'package:resturant/wrapper.dart';

class LogIn extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String email;
  String password;

  @override
  Widget build(BuildContext context) {
    final randomState = Provider.of<RandomStates>(context);
    return randomState.loading
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
                        'LOG IN',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                          fontSize: 27.5,
                        ),
                      ),
                      SizedBox(height: 65),
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
                        padding: randomState.logError == ''
                            ? const EdgeInsets.all(0)
                            : const EdgeInsets.all(8.0),
                        child: Text(
                          randomState.logError ?? '',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: randomState.logError == '' ? 0 : 20,
                          ),
                        ),
                      ),
                      RoundedButton(
                        text: 'CONFIRM',
                        color: Colors.green,
                        press: () async {
                          if (_formKey.currentState.validate()) {
                            randomState.toggleLoading();
                            dynamic result = await Auth()
                                .signInWithEmailAndPassword(email, password);
                            if (result != null) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Wrapper()));
                            } else {
                              randomState.updateLogErrorMassage();
                              randomState.toggleLoading();
                            }
                          }
                        },
                      ),
                      AlreadyHaveAnAccountCheck(
                        login: true,
                        press: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return SignUp();
                              },
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 30)
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
