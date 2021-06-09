import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:resturant/firebase/firestore.dart';
import 'package:resturant/models/user.dart';

class Auth {
  User logedInUser;
  String uid;
  String isAdmin;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Userr _userFromFirebaseUser(User user) {
    return user != null ? Userr(uid: user.uid) : null;
  }

  Future signInWithEmailAndPassword(String email, String pass) async {
    try {
      dynamic result =
          await _auth.signInWithEmailAndPassword(email: email, password: pass);

      User user = result.user;

      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
    }
  }

  Future regWithEmailAndPass(String email, String pass, String username) async {
    try {
      dynamic result = await _auth.createUserWithEmailAndPassword(
          email: email, password: pass);
      User user = result.user;

      await FireStoreService().upadteUserData(username, email, user.uid);

      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
