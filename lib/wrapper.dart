import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:resturant/common_components/loading.dart';
import 'package:resturant/firebase/auth.dart';
import 'package:resturant/views/admin_pages/admin_homepage.dart';
import 'package:resturant/views/common_pages/sign_up.dart';
import 'package:resturant/views/user_pages/user_home_page.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  void initState() {
    super.initState();
    adminCheck();
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  User logedInUser;
  String uid;
  String isAdmin = '';
  bool loading = true;

  void adminCheck() async {
    try {
      final user = _auth.currentUser;

      if (user != null) logedInUser = user;

      uid = logedInUser.uid;
      print('THIIIISSS ISSSSSS USER IDDDDD :$uid');

      var userData =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      setState(() {
        isAdmin = userData.data()['admin'];
        loading = false;
      });
    } catch (e) {
      setState(() {
        print('failed');
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : isAdmin == 'true'
            ? AdminHomePage()
            : UserHomePage();
  }
}
