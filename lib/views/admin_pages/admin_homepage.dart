import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:resturant/admin_components/home_page_button.dart';
import 'package:resturant/views/admin_pages/add_category.dart';
import 'package:resturant/views/admin_pages/add_meal.dart';
import 'package:resturant/views/admin_pages/offers.dart';
import 'package:resturant/views/admin_pages/orders.dart';

class AdminHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back),
        title: Text('Admin panel'),
        backgroundColor: Colors.green,
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.green,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
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
                AdminButton(
                  text: 'لائحة الطلبات',
                  function: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Orders()));
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
