import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:resturant/admin_components/input_field.dart';
import 'package:resturant/firebase/firestore.dart';

class AddMeal extends StatelessWidget {
  String mealName;
  String price;
  String categoryName;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('اضف وجبة'),
          backgroundColor: Colors.green,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              RoundedInputField(
                hintText: 'اسم الوجبة',
                icon: Icons.fastfood_outlined,
                color: Colors.green,
                onChanged: (val) {
                  mealName = val;
                },
              ),
              RoundedInputField(
                hintText: 'المكونات',
                isMultiLine: true,
                icon: Icons.line_style_sharp,
                color: Colors.green,
                onChanged: (val) {
                  categoryName = val;
                },
              ),
              RoundedInputField(
                hintText: 'السعر',
                icon: Icons.monetization_on_outlined,
                color: Colors.green,
                onChanged: (val) {
                  price = val;
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ExpansionTile(
                    expandedAlignment: Alignment.centerLeft,
                    title: Text(
                      'Category',
                      style: TextStyle(color: Colors.black54),
                    ),
                    leading: Icon(
                      Icons.filter_list,
                      color: Colors.green,
                    ),
                    children: [
                      StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('collectionPath')
                            .snapshots(),
                        builder: FireStoreService().buildUserList,
                      )
                    ],
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  FireStoreService()
                      .addMeal('meal image', mealName, price, categoryName);
                },
                child: Text('add'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
