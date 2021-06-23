import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resturant/Lists/cart_list.dart';
import 'package:resturant/firebase/firestore.dart';
import 'package:resturant/models/cart_meal.dart';
import 'package:resturant/random_states.dart';
import 'package:resturant/globals.dart' as globals;

class Cart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String uid = Provider.of<RandomStates>(context).getCurrentUser();
    return StreamProvider.value(
      value: FireStoreService(userId: uid ?? "Anas").cartMeals,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: globals.userCheck == 'true'
              ? IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.deepOrange[400],
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              : null,
          title: Text(
            'Cart Items',
            style: TextStyle(color: Colors.deepOrange),
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.delete,
                color: Colors.deepOrange,
                size: 27.5,
              ),
              onPressed: () {
                print("Delete");
                FireStoreService().deleteAllCartMeals(uid: uid);
              },
            ),
          ],
          backgroundColor: Colors.white,
          elevation: 0,
          automaticallyImplyLeading: true,
        ),
        body: CartList(),
        floatingActionButton: CartFloatingButton(),
      ),
    );
  }
}

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
                width: 400,
                height: 70,
                child: Padding(
                  padding: const EdgeInsets.only(right: 20.0, left: 45),
                  child: FloatingActionButton(
                    onPressed: () {
                      print("Confirm Order");
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Confirm Order ",
                          style: TextStyle(fontSize: 22),
                        ),
                        Text('${totalCartPrice.toStringAsFixed(2)}'),
                      ],
                    ),
                    isExtended: true,
                  ),
                ),
              );
  }
}

// StreamProvider.value(
// value: FireStoreService(
// userId: Provider.of<RandomStates>(context, listen: false)
// .getCurrentUser())
// .cartMeals),

// StreamProvider.value(
// value: FireStoreService(
// userId: Provider.of<RandomStates>(context, listen: false)
// .getCurrentUser())
// .cartMeals),
