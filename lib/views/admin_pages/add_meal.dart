import 'dart:io' show File;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resturant/Lists/category_list.dart';
import 'package:resturant/admin_components/get_image_button.dart';
import 'package:resturant/common_components/rounded_button.dart';
import 'file:///C:/Users/NTC/AndroidStudioProjects/resturant/lib/common_components/input_field.dart';
import 'package:resturant/firebase/firestore.dart';
import 'package:resturant/main.dart';
import 'package:resturant/models/category.dart';
import 'package:resturant/random_states.dart';

class AddMeal extends StatelessWidget {
  final String url;
  final File file;

  AddMeal({this.url, this.file});

  String mealName;
  String mealPrice;
  String mealDetails;
  String categoryName;

  bool isOffer = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('اضف وجبة'),
        backgroundColor: Colors.green,
      ),
      body: Form(
        key: _formKey,
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: ListView(
              children: [
                file != null
                    ? Image.file(
                        file,
                        height: size.height * 0.3,
                      )
                    : GetImageButton(size: size, from: 'meal'),
                SizedBox(
                  height: 20,
                ),
                RoundedInputField(
                  validator: (String val) =>
                      val.isEmpty ? 'ادخل اسم الوجبة' : null,
                  hintText: 'اسم الوجبة',
                  icon: Icons.fastfood_outlined,
                  color: Colors.green,
                  onChanged: (val) {
                    mealName = val;
                  },
                ),
                RoundedInputField(
                  hintText: 'المكونات',
                  validator: (String val) =>
                      val.isEmpty ? 'ادخل تفاصيل الوجبة' : null,
                  isMultiLine: true,
                  icon: Icons.line_style_sharp,
                  color: Colors.green,
                  onChanged: (val) {
                    mealDetails = val;
                  },
                ),
                RoundedInputField(
                  validator: (String val) =>
                      val.isEmpty ? 'ادخل سعر الوجبة' : null,
                  isNumber: true,
                  hintText: 'السعر',
                  icon: Icons.monetization_on_outlined,
                  color: Colors.green,
                  onChanged: (val) {
                    mealPrice = val;
                  },
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(25),
                  ),
                  height: 220,
                  child: CategoryList(
                    isGroupButton: true,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                  child: CheckboxListTile(
                    title: Text('Click to add to Offer list'),
                    activeColor: Colors.green,
                    checkColor: Colors.white,
                    value: Provider.of<RandomStates>(context).isOffer,
                    onChanged: (bool value) {
                      Provider.of<RandomStates>(context, listen: false)
                          .offerChose(value);
                    },
                  ),
                ),
                RoundedButton(
                  text: 'اضافة',
                  color: Colors.green,
                  textColor: CupertinoColors.white,
                  press: () {
                    if (_formKey.currentState.validate()) {
                      FireStoreService().addMeal(
                        mealImage: url,
                        mealName: mealName,
                        mealDetails: mealDetails,
                        mealPrice: double.parse(mealPrice),
                        categoryName:
                            Provider.of<RandomStates>(context, listen: false)
                                .categoryName,
                        isOffers:
                            Provider.of<RandomStates>(context, listen: false)
                                .isOffer,
                      );
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Padding(
// padding: const EdgeInsets.symmetric(vertical: 10),
// child: Container(
// decoration: BoxDecoration(
// color: Colors.grey[300],
// borderRadius: BorderRadius.circular(25),
// ),
// child: SingleChildScrollView(
// physics: ScrollPhysics(),
// child: StreamBuilder(
// stream: FirebaseFirestore.instance
//     .collection('categories')
// .snapshots(),
// builder: FireStoreService().buildCategoryList,
// ),
// ),
// ),
// ),
