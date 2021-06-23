import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:resturant/common_components/loading.dart';

import 'file:///C:/Users/NTC/AndroidStudioProjects/resturant/lib/views/user_pages/home_page.dart';
import 'package:resturant/views/admin_pages/admin_homepage.dart';
import 'firebase/auth.dart';
import 'globals.dart' as globals;

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User logedInUser;

  String uid;

  String isAdmin = '';

  bool loading2 = true;

  void adminCheck() async {
    try {
      final user = _auth.currentUser;
      if (user != null) logedInUser = user;
      uid = logedInUser.uid;

      var userData =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      setState(() {
        isAdmin = userData.data()['admin'] ?? '';
        loading2 = false;
      });
    } catch (e) {
      print('failed');
      setState(() {
        loading2 = false;
      });
    }
  }

  void createAccount() async {
    dynamic result = await Auth().signInAnonymously();
    if (result == null) print('Error sign in anonumsly');
  }

  @override
  void initState() {
    super.initState();
    adminCheck();
    createAccount();
  }

  @override
  Widget build(BuildContext context) {
    // final randomState = Provider.of<RandomStates>(context, listen: false);
    // randomState.adminCheck();
    print('WRAPPER CHECK $isAdmin');
    print('USER ID IS $uid');

    globals.setAdminValue(isAdmin);
    print('WRAPPER CHECK ${globals.userCheck}');

    return loading2
        ? Loading()
        : isAdmin == 'true'
            ? AdminHomepage()
            : HomePage();
  }
}
