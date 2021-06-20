import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class RandomStates extends ChangeNotifier {
  String categoryName;
  String logError = '';
  // String isAdmin = 'false';

  bool isOffer = false;
  bool loading = false;
  bool loading2 = true;

  int radioValue;

  void getCategoryName(String newName) {
    categoryName = newName;
    notifyListeners();
  }

  void offerChose(bool value) {
    isOffer = value;
    notifyListeners();
  }

  void getRadioValue(int i) {
    radioValue = i;
    notifyListeners();
  }

  void toggleLoading() {
    loading = !loading;
    notifyListeners();
  }

  void updateLogErrorMassage() {
    logError = 'ايميل غير صحيح';
    notifyListeners();
  }

  String getCurrentUser() {
    User logedInUser;
    final FirebaseAuth _auth = FirebaseAuth.instance;
    String uid;
    final user = _auth.currentUser;

    if (user != null) {
      logedInUser = user;

      uid = logedInUser.uid;

      return uid;
    }
    return 'No User';
  }

  // void adminCheck() async {
  //   try {
  //     final String uid = getCurrentUser();
  //     var userData =
  //         await FirebaseFirestore.instance.collection('users').doc(uid).get();
  //     isAdmin = userData.data()['admin'];
  //     loading2 = false;
  //     print('adminChick');
  //     notifyListeners();
  //   } catch (e) {
  //     print('failed');
  //     loading2 = false;
  //     notifyListeners();
  //   }
  // }
}
