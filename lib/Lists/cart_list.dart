import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resturant/models/cart_meal.dart';

class CartList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cartMeals = Provider.of<List<CartMeal>>(context);
    return ListView.builder(
      itemCount: cartMeals?.length ?? 0,
      itemBuilder: (context, index) {
        return CartCard(
          cartMeal: cartMeals[index],
        );
      },
    );
  }
}

class CartCard extends StatelessWidget {
  final CartMeal cartMeal;

  CartCard({this.cartMeal});

  @override
  Widget build(BuildContext context) {
    print(cartMeal.mealName);
    return Container(
      child: Column(
        children: [
          Text(cartMeal.mealName),
          Text('${cartMeal.mealPrice} JD'),
          Image.network(cartMeal.mealImage),
        ],
      ),
    );
  }
}
