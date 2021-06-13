import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resturant/Lists/category_list.dart';
import 'package:resturant/firebase/firestore.dart';
import 'package:resturant/views/common_pages/log_in.dart';
import 'package:resturant/views/common_pages/sign_up.dart';

class UserHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(
          'Categories',
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.account_box),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => LogIn()));
            },
          )
        ],
      ),
      body: CategoryList(),
    );
  }
}
