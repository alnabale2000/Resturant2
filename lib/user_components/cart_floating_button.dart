import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resturant/models/cart_meal.dart';

class CartFloatingButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double totalCartPrice = 0;
    final cartMeals = Provider.of<List<CartMeal>>(context);
    if (cartMeals != null)
      for (CartMeal cartMeal in cartMeals) {
        totalCartPrice += cartMeal.totalPrice;
      }
    print(totalCartPrice);

    return cartMeals == null
        ? Container()
        : cartMeals.isEmpty
            ? Container()
            : Container(
                width: double.infinity,
                height: 70,
                child: Padding(
                  padding: const EdgeInsets.only(right: 15.0, left: 45),
                  child: FloatingActionButton(
                    onPressed: () {
                      print("Confirm Order");
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "Confirm Order ",
                          style: TextStyle(fontSize: 23.5),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.black87, width: 1),
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Text(
                              'Total : ${totalCartPrice.toStringAsFixed(2)}',
                              style:
                                  TextStyle(color: Colors.green, fontSize: 15),
                            ),
                          ),
                        ),
                      ],
                    ),
                    isExtended: true,
                  ),
                ),
              );
  }
}
