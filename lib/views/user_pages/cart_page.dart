import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resturant/Lists/cart_list.dart';
import 'package:resturant/firebase/firestore.dart';
import 'package:resturant/random_states.dart';

class Cart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('cartPage');

    return StreamProvider.value(
      value: FireStoreService(
              userId: Provider.of<RandomStates>(context).getCurrentUser() ??
                  'No User')
          .cartMeals,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.5,
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
