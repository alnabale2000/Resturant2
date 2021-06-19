import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resturant/Lists/cart_list.dart';
import 'package:resturant/firebase/firestore.dart';
import 'package:resturant/random_states.dart';

class Cart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
      value: FireStoreService(
              userId: Provider.of<RandomStates>(context).getCurrentUser())
          .cartMeals,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          automaticallyImplyLeading: true,
        ),
        body: CartList(),
      ),
    );
  }
}

// StreamProvider.value(
// value: FireStoreService(
// userId: Provider.of<RandomStates>(context, listen: false)
// .getCurrentUser())
// .cartMeals),
