import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resturant/Lists/cart_list.dart';
import 'package:resturant/firebase/firestore.dart';
import 'package:resturant/random_states.dart';

class Cart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String uid = Provider.of<RandomStates>(context).getCurrentUser();
    return StreamProvider.value(
      value: FireStoreService(userId: uid ?? "Anas").cartMeals,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.deepOrange[400],
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
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
        floatingActionButton: Container(
          width: 300,
          height: 70,
          child: Padding(
            padding: const EdgeInsets.only(right: 58.0),
            child: FloatingActionButton(
              onPressed: () {
                print("Confirm Order");
              },
              child: Text(
                "Confirm Order ",
                style: TextStyle(fontSize: 22),
              ),
              isExtended: true,
            ),
          ),
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
