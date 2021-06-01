import 'package:flutter/material.dart';
import 'package:resturant/admin_components/home_page_button.dart';
import 'package:resturant/firebase/firestore.dart';
import 'package:resturant/views/admin_pages/add_category.dart';
import 'package:resturant/views/admin_pages/add_meal.dart';

class AdminHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back),
        title: Text('Admin panel'),
        backgroundColor: Colors.green,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AdminButton(
                  text: 'اضف قسم',
                  function: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AddCategory()));
                  },
                ),
                AdminButton(
                  text: 'اضف وجبة',
                  function: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AddMeal()));
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                AdminButton(
                  text: 'لائحة الطلبات',
                ),
                AdminButton(
                  text: 'العروض',
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
