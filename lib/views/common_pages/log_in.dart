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
import 'package:resturant/globals.dart' as global;

class LogIn extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String email;
  String password;

  @override
  Widget build(BuildContext context) {
    print('${global.userCheck} IN LOG INNN');
    final randomState = Provider.of<RandomStates>(context);
    return randomState.loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.deepOrange[400],
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
                      SizedBox(height: 65),
                      Text(
                        'LOG IN',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.deepOrange[400],
                          fontSize: 27.5,
                        ),
                      ),
                      SizedBox(height: 65),
                      RoundedInputField(
                        validator: (String val) =>
                            val.isEmpty ? 'ادخل بريدك الالكتروني' : null,
                        hintText: 'البريد الالكتروني',
                        icon: Icons.email_outlined,
                        color: Colors.deepOrange[400],
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
                        color: Colors.deepOrange[400],
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
                        color: Colors.deepOrange[400],
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
                      SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 1,
                            width: 140,
                            color: Colors.deepOrange[300],
                          ),
                          Text(
                            'Or Login with',
                            style: TextStyle(color: Colors.black87),
                          ),
                          Container(
                            height: 1,
                            width: 140,
                            color: Colors.deepOrange[300],
                          ),
                        ],
                      ),
                      SizedBox(height: 27.5),
                      GestureDetector(
                        child: Container(
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black54,
                                offset: Offset(0, 2.5),
                                spreadRadius: -2,
                                blurRadius: 4,
                              ),
                            ],
                          ),
                          height: 44,
                          width: 230,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Image.network(
                                  'https://facebookbrand.com/wp-content/uploads/2019/04/f_logo_RGB-Hex-Blue_512.png?w=512&h=512',
                                  fit: BoxFit.contain,
                                ),
                                Text(
                                  'Login with Facebook',
                                  style: TextStyle(
                                      color: Color(0xFF1778F2), fontSize: 17.5),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
