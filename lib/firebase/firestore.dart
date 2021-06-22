import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:resturant/models/cart_meal.dart';
import 'package:resturant/models/category.dart';
import 'package:resturant/models/meal.dart';
import 'package:resturant/models/order.dart';

class FireStoreService {
  final String catNameFromProvider;
  final String userId;

  FireStoreService({this.catNameFromProvider, this.userId});

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

  ///
  // void setOfferCollection() {
  //   categoriesCollection.doc('Offers').update({'category_name': 'Offers'});
  // }
  ///
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
        'meal_image': mealImage,
        'meal_price': mealPrice,
        'meal_details': mealDetails,
      },
    );
    isOffers
        ? categoriesCollection
            .doc('Offers')
            .collection('meals')
            .doc(mealName)
            .set(
            {
              'meal_name': mealName,
              'meal_image': mealImage,
              'meal_price': mealPrice,
              'meal_details': mealDetails,
            },
          )
        : null;
  }

  void addToUserCart({
    String uid,
    String mealName,
    double mealPrice,
    mealDetails,
    String mealImage,
    int count,
    double totalPrice,
  }) {
    usersCollection.doc(uid).collection('user_orders').doc(mealName).set({
      'meal_name': mealName,
      'meal_price': mealPrice,
      'meal_details': mealDetails,
      'meal_image': mealImage,
      'count': count,
      'total_price': totalPrice,
    });

    // ordersCollection.add({'meal_name': mealName,'meal_price':mealPrice,'meal_image':mealImage,''},);
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
    return categoriesCollection
        .doc(catNameFromProvider)
        .collection('meals')
        .snapshots()
        .map(_mealList);
  }

  List<CartMeal> _cartMealList(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) => CartMeal.fromFireStore(doc)).toList();
  }

  Stream<List<CartMeal>> get cartMeals {
    return usersCollection
        .doc(userId)
        .collection('user_orders')
        .snapshots()
        .map(_cartMealList);
  }

  /// END GET meal
  //  ------------------------------------END GET SECTION------------------------------------------------

  //  ------------------------------------START DELETE SECTION-------------------------------------------

  void deleteAllAdminOrders() async {
    // ordersCollection.get().then((snapshot) {
    //   for (DocumentSnapshot documentSnapshot in snapshot.docs)
    //     documentSnapshot.reference.delete();
    // });
    dynamic snapshot = await ordersCollection.get();
    for (DocumentSnapshot documentSnapshot in snapshot.docs)
      documentSnapshot.reference.delete();
  }

  void deleteAllCartMeals({String uid}) async {
    dynamic snapshot =
        await usersCollection.doc(uid).collection('user_orders').get();
    for (DocumentSnapshot documentSnapshot in snapshot.docs) {
      documentSnapshot.reference.delete();
    }
  }

  void deleteSingleCartMealDoc({String uid, String mealName}) async {
    await usersCollection
        .doc(uid)
        .collection('user_orders')
        .doc(mealName)
        .delete();
  }

  void deleteSingleOrderDocument({String orderId}) async {
    await ordersCollection.doc(orderId).delete();
  }

  void deleteSingleMealDocument(
      {String mealName, String collectionName}) async {
    await categoriesCollection
        .doc(collectionName)
        .collection('meals')
        .doc(mealName)
        .delete();

    await categoriesCollection
        .doc('Offers')
        .collection('meals')
        .doc(mealName)
        .delete();
  }

  void deleteSingleCategoryDocument({String categoryName}) async {
    await categoriesCollection.doc(categoryName).delete();
  }

  //  ------------------------------------END DELETE SECTION-------------------------------------------

  // -------------------------------------START USER SECTION-------------------------------------------

  Future updateUserData(
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
