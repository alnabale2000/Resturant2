library my_prj.globals;

String userCheck = '';

void setAdminValue(String isAdmin) {
  userCheck = isAdmin;
}

// Future<dynamic> adminCheck() async {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//
//   User logedInUser;
//
//   String uid;
//
//   try {
//     final user = _auth.currentUser;
//
//     if (user != null) logedInUser = user;
//
//     uid = logedInUser.uid;
//
//     var userData =
//         await FirebaseFirestore.instance.collection('users').doc(uid).get();
//     // setState(() {
//     //   isAdmin = userData.data()['admin'];
//     // });
//     return userData;
//   } catch (e) {
//     print('failed');
//   }
// }
