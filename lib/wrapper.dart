import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resturant/common_components/loading.dart';
import 'package:resturant/random_states.dart';
import 'file:///C:/Users/NTC/AndroidStudioProjects/resturant/lib/views/user_pages/home_page.dart';
import 'package:resturant/views/admin_pages/admin_homepage2.dart';
import 'package:resturant/views/admin_pages/admin_homepage.dart';
import 'package:resturant/views/user_pages/user_home_page.dart';
import 'globals.dart' as globals;

class Wrapper extends StatelessWidget {
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  // User logedInUser;
  // String uid;
  // String isAdmin = '';
  // bool loading = true;

  // void adminCheck() async {
  //   try {
  //     final user = _auth.currentUser;
  //
  //     if (user != null) logedInUser = user;
  //
  //     uid = logedInUser.uid;
  //
  //     var userData =
  //         await FirebaseFirestore.instance.collection('users').doc(uid).get();
  //     setState(() {
  //       isAdmin = userData.data()['admin'];
  //       loading = false;
  //     });
  //   } catch (e) {
  //     setState(() {
  //       print('failed');
  //       loading = false;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final randomState = Provider.of<RandomStates>(context, listen: false);
    randomState.adminCheck();
    return randomState.loading2
        ? Loading()
        : randomState.isAdmin == 'true'
            ? AdminHomepage()
            : HomePage();
  }
}
