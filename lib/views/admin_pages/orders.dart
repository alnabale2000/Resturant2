// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:resturant/Lists/orders_list.dart';
// import 'package:resturant/firebase/firestore.dart';
// import 'package:resturant/models/order.dart';
//
// class Orders extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return StreamProvider.value(
//       value: FireStoreService().orders,
//       child: Scaffold(
//         appBar: AppBar(
//           backgroundColor: Colors.green,
//           title: Text('الطلبات'),
//           actions: [
//             IconButton(
//               icon: Icon(
//                 Icons.replay,
//                 color: Colors.white,
//               ),
//               onPressed: () {
//                 FireStoreService().deleteAllDocs();
//               },
//             ),
//           ],
//         ),
//         body: OrdersList(),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resturant/Lists/orders_list.dart';
import 'package:resturant/firebase/firestore.dart';
import 'package:resturant/models/order.dart';

class Orders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('test4');
    return StreamProvider.value(
      value: FireStoreService().orders,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: OrdersList(),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.deepOrange,
          child: Icon(
            Icons.replay,
            color: Colors.white,
          ),
          onPressed: () {
            FireStoreService().deleteAllDocs();
          },
        ),
      ),
    );
  }
}
