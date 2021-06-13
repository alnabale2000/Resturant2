import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resturant/models/meal.dart';

class MealList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final meals = Provider.of<List<Meal>>(context);
    return ListView.builder(
      itemCount: meals?.length ?? 0,
      itemBuilder: (context, index) {
        return MealCard(
          meal: meals[index],
        );
      },
    );
  }
}

class MealCard extends StatelessWidget {
  final Meal meal;

  MealCard({this.meal});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(meal.mealName),
        Text('${meal.mealPrice}'),
      ],
    );
  }
}
