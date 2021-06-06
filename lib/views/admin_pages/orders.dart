import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resturant/Lists/orders_list.dart';
import 'package:resturant/firebase/firestore.dart';
import 'package:resturant/models/order.dart';

class Orders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
      initialData: [],
      value: FireStoreService().orders,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text('الطلبات'),
          actions: [
            IconButton(
              icon: Icon(
                Icons.replay,
                color: Colors.white,
              ),
              onPressed: () {
                FireStoreService().deleteAllDocs();
              },
            ),
          ],
        ),
        body: OrdersList(),
      ),
    );
  }
}
