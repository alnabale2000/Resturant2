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
    categoriesCollection.doc(categoryName).collection('meals').add(
      {
        'meal_name': mealName,
        'meal_price': mealPrice,
        'meal_details': mealDetails,
      },
    );
    isOffers
        ? offersCollection.add(
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

  Stream<List<Category>> get category {
    return ordersCollection.snapshots().map(_categoryList);
  }

  /// END GET category

  /// START GET meal
  List<Meal> _mealList(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) => Meal.fromFireStore(doc)).toList();
  }

  Stream<List<Meal>> get meals {
    return ordersCollection.snapshots().map(_mealList);
  }

  /// END GET meal
  //  ------------------------------------END GET SECTION-------------------------------------------

  //  ------------------------------------START DELETE SECTION-------------------------------------------

  void deleteAllDocs() {
    ordersCollection.get().then((snaphot) {
      for (DocumentSnapshot documentSnapshot in snaphot.docs)
        documentSnapshot.reference.delete();
    });
  }

  //  ------------------------------------END DELETE SECTION-------------------------------------------

  Widget buildCategoryList(
      BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot, W) {
    int chosen;
    int _value;
    if (snapshot.hasData) {
      return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: snapshot.data.docs.length,
        itemBuilder: (context, index) {
          DocumentSnapshot category = snapshot.data.docs[index];

          return ListTile(
            onTap: () {},
            title: Text(category.id),
            leading: Radio(
              value: index,
              groupValue: _value,
              onChanged: (val) {
                chosen = val;
              },
            ),
          );
        },
      );
    } else if (snapshot.connectionState == ConnectionState.done &&
        !snapshot.hasData) {
      // Handle no data
      return Center(
        child: Text("لا يوجد اقسام"),
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
