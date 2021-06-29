import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resturant/common_components/loading.dart';
import 'package:resturant/firebase/firestore.dart';
import 'package:resturant/models/cart_meal.dart';
import 'package:resturant/models/meal.dart';
import 'package:resturant/views/user_pages/meal_details.dart';

import '../constant.dart';
import '../random_states.dart';

class CartList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cartMeals = Provider.of<List<CartMeal>>(context);
    final cartAdditionalMeals = Provider.of<List<Meal>>(context);
    // print('IN CART LIST PAGE ${cartAdditionalMeals?.length ?? '556'}');
    return cartMeals == null
        ? Center(child: Loading())
        : cartMeals.isEmpty
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    'Add Items To Cart ِAnd Try Again',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 30),
                  ),
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: cartMeals?.length ?? 0,
                      itemBuilder: (context, index) {
                        return CartCard(
                          cartMeal: cartMeals[index],
                        );
                      },
                    ),
                    SizedBox(height: 30),
                    SizedBox(
                      height: 200,
                      child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: cartAdditionalMeals?.length ?? 0,
                        itemBuilder: (context, index) {
                          return CartAdditionalCard(
                            cartAdditionalMeal: cartAdditionalMeals[index],
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 120)
                  ],
                ),
              );
  }
}

class CartAdditionalCard extends StatelessWidget {
  final Meal cartAdditionalMeal;

  CartAdditionalCard({this.cartAdditionalMeal});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        child: FittedBox(
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(width: 1, color: Colors.green),
                boxShadow: [BoxShadow()]),
            width: 150,
            child: Column(
              children: [
                SizedBox(
                  child: cartAdditionalMeal.mealImage == 'No image'
                      ? Container(
                          width: 150,
                          height: 120,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                          ),
                          child: Center(
                            child: Icon(Icons.image_not_supported_rounded),
                          ),
                        )
                      : Image.network(
                          cartAdditionalMeal.mealImage,
                          fit: BoxFit.cover,
                        ),
                  height: 120,
                  width: 150,
                ),
                Text(
                  cartAdditionalMeal.mealName,
                  style: TextStyle(
                      color: Colors.deepOrange,
                      fontSize: 17.5,
                      fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    '${cartAdditionalMeal.mealPrice}',
                    style:
                        TextStyle(color: Colors.deepOrange[400], fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MealDetails(
                        meal: cartAdditionalMeal,
                      )));
        },
      ),
    );
  }
}

class CartCard extends StatelessWidget {
  final CartMeal cartMeal;

  CartCard({this.cartMeal});

  @override
  Widget build(BuildContext context) {
    String uid =
        Provider.of<RandomStates>(context, listen: false).getCurrentUser();
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.only(top: 18.0, left: 12),
                child: FittedBox(
                  child: Container(
                    height: 180,
                    width: 380,
                    child: Material(
                      borderRadius: (BorderRadius.circular(24.0)),
                      elevation: 32.5,
                      shadowColor: Colors.red,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 18.0),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Row(
                                children: [
                                  cartMeal.mealImage == 'No image'
                                      ? Container(
                                          width: 100,
                                          height: 100,
                                          child: CircleAvatar(
                                            backgroundColor: Colors.grey[200],
                                            child: Center(
                                              child: Icon(Icons
                                                  .image_not_supported_rounded),
                                            ),
                                          ),
                                        )
                                      : Container(
                                          height: 100,
                                          width: 100,
                                          child: CircleAvatar(
                                            radius: 20,
                                            backgroundImage: NetworkImage(
                                                cartMeal.mealImage),
                                          ),
                                        ),
                                  Column(
                                    children: [
                                      Container(
                                        child: Text(
                                          cartMeal.mealName,
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 22.5,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 50, left: 0.0, top: 12),
                                        child: Text(
                                          '${(cartMeal.mealPrice * cartMeal.count).toStringAsFixed(2)} JD',
                                          style: style1,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 28.0),
                                    child: Align(
                                      alignment: Alignment.topRight,
                                      child: IconButton(
                                          icon: Icon(
                                            Icons.cancel,
                                            size: 42,
                                            color: Colors.deepOrange,
                                          ),
                                          onPressed: () {
                                            print("Cancel");
                                            FireStoreService()
                                                .deleteSingleCartMealDoc(
                                                    mealName: cartMeal.mealName,
                                                    uid: uid);
                                          }),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Stack(
                                  children: [
                                    Container(
                                      width: 100,
                                      height: 35,
                                      decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius: BorderRadius.circular(23),
                                      ),
                                    ),
                                    Positioned(
                                      // bottom:2 ,
                                      // width: 15,
                                      left: 0,
                                      top: -6,
                                      // right: -1,
                                      child: IconButton(
                                          icon: Icon(Icons.add),
                                          onPressed: () {
                                            FireStoreService().editCount(
                                              uid: uid,
                                              count: cartMeal.count + 1,
                                              mealName: cartMeal.mealName,
                                              totalPrice: (cartMeal.count + 1) *
                                                  cartMeal.mealPrice,
                                            );
                                          }),
                                    ),
                                    Positioned(
                                      width: 26,
                                      height: 35,
                                      left: 35,
                                      child: Container(
                                        height: 12,
                                        width: 12,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(22)),
                                        child: Center(
                                            child: num == null
                                                ? Text(
                                                    "${cartMeal.count}",
                                                    style: style1,
                                                  )
                                                : Text(
                                                    "${cartMeal.count}",
                                                    style: style1,
                                                  )),
                                      ),
                                    ),
                                    Positioned(
                                      right: 0,
                                      left: 50,
                                      bottom: 1,
                                      child: IconButton(
                                          icon: Icon(Icons.minimize),
                                          onPressed: () {
                                            FireStoreService().editCount(
                                              uid: uid,
                                              count: cartMeal.count - 1,
                                              mealName: cartMeal.mealName,
                                              totalPrice: (cartMeal.count - 1) *
                                                  cartMeal.mealPrice,
                                            );
                                          }),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: Container(
                                child: Text(
                                  "Details",
                                  style: TextStyle(
                                      fontFamily: 'Pacifico',
                                      color: Colors.red,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
