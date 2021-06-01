import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FireStoreService {
  final CollectionReference categories =
      FirebaseFirestore.instance.collection('categories');

  final CollectionReference categoryMeals =
      FirebaseFirestore.instance.collection('meals');

  void addCategory(String image, String categoryName) async {
    await categories
        .doc(categoryName)
        .set({'image_url': image, 'category_name': categoryName});
  }

  void addMeal(
      String image, String mealName, String price, String categoryName) {
    categories.doc(categoryName).collection('meals').add({
      'meal_name': mealName,
      'meal_price': price,
    });
  }

  // Future<void> getData() async {
  //   // Get docs from collection reference
  //   QuerySnapshot querySnapshot = await categories.get();
  //
  //   // Get data from docs and convert map to List
  //   final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
  //
  //   return allData;
  // }
  Widget buildUserList(
      BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    if (snapshot.hasData) {
      return ListView.builder(
        itemCount: snapshot.data.docs.length,
        itemBuilder: (context, index) {
          DocumentSnapshot category = snapshot.data.docs[index];

          return Container(
            child: Text(category.id),
          );
        },
      );
    } else if (snapshot.connectionState == ConnectionState.done &&
        !snapshot.hasData) {
      // Handle no data
      return Center(
        child: Text("No category found."),
      );
    } else {
      // Still loading
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(child: CircularProgressIndicator()),
      );
    }
  }
}
