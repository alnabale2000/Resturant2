import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resturant/Lists/category_list.dart';
import 'package:resturant/firebase/firestore.dart';

class UserHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
      value: FireStoreService().categories,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text(
            'Categories',
          ),
        ),
        body: CategoryList(),
      ),
    );
  }
}
