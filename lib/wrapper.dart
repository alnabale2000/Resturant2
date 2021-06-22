import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resturant/common_components/loading.dart';
import 'package:resturant/firebase/firestore.dart';
import 'package:resturant/random_states.dart';
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

  String isAdmin = 'false';

  bool loading2 = true;

  void adminCheck() async {
    try {
      final user = _auth.currentUser;
      if (user != null) logedInUser = user;
      uid = logedInUser.uid;

      var userData =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      setState(() {
        isAdmin = userData.data()['admin'];
        loading2 = false;
      });
    } catch (e) {
      print('failed');
      loading2 = false;
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
    // FireStoreService().setOfferCollection();
  }

  @override
  Widget build(BuildContext context) {
    // final randomState = Provider.of<RandomStates>(context, listen: false);
    // randomState.adminCheck();
    globals.setAdminValue(isAdmin);
    print('${globals.userCheck} TEEEEEEEESSSSSST');
    return loading2
        ? Loading()
        : isAdmin == 'true'
            ? AdminHomepage()
            : HomePage();
  }
}
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
