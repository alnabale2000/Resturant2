import 'package:cloud_firestore/cloud_firestore.dart';

class Order {
  final String userName;
  final String phoneNumber;
  final String mealName;
  final String mealImage;
  final String mealDateTime;
  final String mealDetails;
  final String mealId;
  final double mealPrice;

  Order(
      {this.userName,
      this.phoneNumber,
      this.mealName,
      this.mealPrice,
      this.mealImage,
      this.mealDateTime,
      this.mealDetails,
      this.mealId});

  factory Order.fromFireStore(DocumentSnapshot doc) {
    Map data = doc.data();
    return Order(
      mealId: doc.id,
      mealImage: data['meal_image'] ?? 'No image',
      mealName: data['meal_name'] ?? 'No name',
      userName: data['username'] ?? 'Unknown',
      phoneNumber: data['phone_number'] ?? 'Unknown',
      mealPrice: data['meal_price'] ?? 0,
      mealDetails: data['meal_details'] ?? 'بلا اضافات',
      mealDateTime: data['order_time'] ?? '12:34:25',
    );
  }
}
