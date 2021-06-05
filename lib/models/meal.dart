import 'package:cloud_firestore/cloud_firestore.dart';

class Meal {
  final String mealImage;
  final String mealName;
  final double mealPrice;
  final String mealDetails;

  Meal({
    this.mealImage,
    this.mealName,
    this.mealPrice,
    this.mealDetails,
  });

  factory Meal.fromFireStore(DocumentSnapshot doc) {
    Map data = doc.data();
    return Meal(
      mealName: data['meal_name'] ?? 'No name',
      mealDetails: data['meal_details'] ?? 'No details',
      mealImage: data['meal_image'] ?? 'No image',
      mealPrice: data['meal_price'] ?? 0,
    );
  }
}
