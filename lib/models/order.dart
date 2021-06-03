import 'package:cloud_firestore/cloud_firestore.dart';

class Order {
  final String userName;
  final String phoneNumber;
  final String mealName;
  final String mealImage;
  final String mealDateTime;
  final double mealPrice;

  Order({
    this.userName,
    this.phoneNumber,
    this.mealName,
    this.mealPrice,
    this.mealImage,
    this.mealDateTime,
  });

  factory Order.fromFireStore(DocumentSnapshot doc) {
    Map data = doc.data();
    return Order(
        mealName: data['meal_name'] ?? 'No name',
        mealImage: data['meal_image'] ?? 'No image',
        mealPrice: data['meal_price'] ?? 0,
        userName: data['username'] ?? '',
        phoneNumber: data['phone_number'] ?? '',
        mealDateTime: data['order_time']);
  }
}
