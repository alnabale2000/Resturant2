import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:resturant/models/category.dart';
import 'package:resturant/models/meal.dart';
import 'package:resturant/models/order.dart';

class FireStoreService {
  final CollectionReference categoriesCollection =
      FirebaseFirestore.instance.collection('categories');

  final CollectionReference categoryMeals =
      FirebaseFirestore.instance.collection('meals');

  final CollectionReference offersCollection =
      FirebaseFirestore.instance.collection('offers');

  final CollectionReference ordersCollection =
      FirebaseFirestore.instance.collection('orders');

  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  //  ---------------------------------START ADD SECTION------------------------------------------------

  void addCategory(String image, String categoryName) async {
    await categoriesCollection
        .doc(categoryName)
        .set({'image_url': image, 'category_name': categoryName});
  }

  void addMeal({
    String mealImage,
    String mealName,
    double mealPrice,
    String categoryName,
    String mealDetails,
    bool isOffers = false,
  }) {
    categoriesCollection
        .doc(categoryName)
        .collection('meals')
        .doc(mealName)
        .set(
      {
        'meal_name': mealName,
        'meal_price': mealPrice,
        'meal_details': mealDetails,
      },
    );
    isOffers
        ? offersCollection.doc(mealName).set(
            {
              'meal_name': mealName,
              'meal_price': mealPrice,
            },
          )
        : null;
  }

  //  ------------------------------------END ADD SECTION---------------------------------------------

  //  ------------------------------------START GET SECTION-------------------------------------------

  /// START GET ORDER
  List<Order> _orderList(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) => Order.fromFireStore(doc)).toList();
  }

  Stream<List<Order>> get orders {
    return ordersCollection.snapshots().map(_orderList);
  }

  /// END GET ORDER

  /// START GET category
  List<Category> _categoryList(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) => Category.fromFireStore(doc)).toList();
  }

  Stream<List<Category>> get categories {
    return categoriesCollection.snapshots().map(_categoryList);
  }

  /// END GET category

  /// START GET meal
  List<Meal> _mealList(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) => Meal.fromFireStore(doc)).toList();
  }

  Stream<List<Meal>> get meals {
    return categoryMeals.snapshots().map(_mealList);
  }

  /// END GET meal
  //  ------------------------------------END GET SECTION------------------------------------------------

  //  ------------------------------------START DELETE SECTION-------------------------------------------

  void deleteAllDocs() {
    ordersCollection.get().then((snapshot) {
      for (DocumentSnapshot documentSnapshot in snapshot.docs)
        documentSnapshot.reference.delete();
    });
  }

  void deleteSingleOrderDocument({String mealName}) async {
    ordersCollection.doc(mealName).delete();
  }

  //  ------------------------------------END DELETE SECTION-------------------------------------------

  // -------------------------------------START USER SECTION-------------------------------------------

  Future upadteUserData(
    String username,
    String email,
    String uid,
  ) async {
    return await usersCollection.doc(uid).set({
      'username': username,
      'email': email,
      'admin': 'false',
    });
  }
}
