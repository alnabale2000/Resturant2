import 'package:flutter/material.dart';
import 'package:resturant/models/meal.dart';

class MealDetails extends StatelessWidget {
  final Meal meal;

  MealDetails({this.meal});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(meal.mealName),
    );
  }
}
