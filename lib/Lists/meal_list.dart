import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resturant/models/meal.dart';
import 'package:resturant/views/user_pages/meal_details.dart';

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
    return GestureDetector(
      child: Container(
        child: Column(
          children: [
            Padding(padding: EdgeInsets.only(top: 20)),
            FittedBox(
              child: Container(
                width: 380,
                child: Material(
                  borderRadius: (BorderRadius.circular(24.0)),
                  elevation: 32.5,
                  shadowColor: Colors.red,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Column(
                          children: [
                            Text(meal.mealName,
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold)),
                            Text('${meal.mealPrice} JD ',
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MealDetails(
              meal: meal,
            ),
          ),
        );
      },
    );
  }
}
