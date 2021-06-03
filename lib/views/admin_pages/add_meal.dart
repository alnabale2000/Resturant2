import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:resturant/admin_components/get_image_button.dart';
import 'package:resturant/admin_components/input_field.dart';
import 'package:resturant/firebase/firestore.dart';

class AddMeal extends StatefulWidget {
  @override
  _AddMealState createState() => _AddMealState();
}

class _AddMealState extends State<AddMeal> {
  String mealName;

  String mealPrice;

  String mealDetails;

  String categoryName;

  bool isOffer = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('اضف وجبة'),
          backgroundColor: Colors.green,
        ),
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: ListView(
            children: [
              GetImageButton(size: size),
              SizedBox(
                height: 20,
              ),
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
                  mealDetails = val;
                },
              ),
              RoundedInputField(
                isNumber: true,
                hintText: 'السعر',
                icon: Icons.monetization_on_outlined,
                color: Colors.green,
                onChanged: (val) {
                  mealPrice = val;
                },
              ),
              RoundedInputField(
                hintText: 'الفئة',
                icon: (Icons.dynamic_feed),
                color: Colors.green,
                onChanged: (val) {
                  categoryName = val;
                },
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                child: CheckboxListTile(
                  title: Text('Click to add to Offer list'),
                  activeColor: Colors.green,
                  checkColor: Colors.white,
                  value: isOffer,
                  onChanged: (bool value) {
                    setState(() {
                      isOffer = value;
                    });
                  },
                ),
              ),
              TextButton(
                onPressed: () {
                  FireStoreService().addMeal(
                    mealImage: 'meal image',
                    mealName: mealName,
                    mealDetails: mealDetails,
                    mealPrice: double.parse(mealPrice),
                    categoryName: categoryName,
                    isOffers: isOffer,
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10)),
                  height: 50,
                  width: 90,
                  child: Center(
                    child: Text(
                      'add',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
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
