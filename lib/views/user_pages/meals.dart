import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resturant/Lists/meal_list.dart';
import 'package:resturant/firebase/firestore.dart';

class Meals extends StatelessWidget {
  final String categoryName;

  Meals({this.categoryName});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider.value(
            value: FireStoreService(catNameFromProvider: categoryName).meals),
        Provider<String>(create: (context) => categoryName),
      ],
      child: MealList(),
    );
  }
}
