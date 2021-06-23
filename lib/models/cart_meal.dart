import 'package:cloud_firestore/cloud_firestore.dart';

class CartMeal {
  final String mealName;
  final String mealImage;
  final String mealDetails;
  final double mealPrice;
  final double totalPrice;
  int count;

  CartMeal(
      {this.mealName,
      this.mealImage,
      this.mealDetails,
      this.mealPrice,
      this.totalPrice,
      this.count});

  factory CartMeal.fromFireStore(DocumentSnapshot doc) {
    Map data = doc.data();
    return CartMeal(
      mealImage: data['meal_image'] ?? 'No image',
      mealName: data['meal_name'] ?? 'No name',
      mealPrice: data['meal_price'] ?? 0,
      mealDetails: data['meal_details'] ?? 'بلا اضافات',
      count: data['count'] ?? 0,
      totalPrice: data['total_price'],
    );
  }
}
