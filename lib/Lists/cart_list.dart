import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resturant/common_components/loading.dart';
import 'package:resturant/firebase/firestore.dart';
import 'package:resturant/models/cart_meal.dart';

import '../random_states.dart';

class CartList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cartMeals = Provider.of<List<CartMeal>>(context);
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: cartMeals?.length ?? 0,
                      itemBuilder: (context, index) {
                        return CartCard(
                          cartMeal: cartMeals[index],
                        );
                      },
                    ),
                    SizedBox(height: 100)
                  ],
                ),
              );
  }
}

class CartCard extends StatefulWidget {
  final CartMeal cartMeal;

  CartCard({this.cartMeal});

  @override
  _CartCardState createState() => _CartCardState();
}

class _CartCardState extends State<CartCard> {
  int numb;
  @override
  void initState() {
    super.initState();
    fillInteger();
  }

  fillInteger() {
    numb = widget.cartMeal.count;
  }

  plus(int index) {
    setState(() {
      numb = index + 1;

      //    prices = numb * price;
    });
  }

  minmize(int index) {
    if (index > 1) {
      setState(() {
        numb = index - 1;

//        prices = numb * price;
      });
    } else
      numb = 1;
  }

  TextStyle Style1 =
      TextStyle(color: Colors.red, fontSize: 15, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    String uid = Provider.of<RandomStates>(context).getCurrentUser();
    print('CART CARD TEST');

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
                                  Container(
                                    height: 100,
                                    width: 100,
                                    child: CircleAvatar(
                                      radius: 20,
                                      backgroundImage: NetworkImage(
                                          widget.cartMeal.mealImage),
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      Container(
                                        child: Text(
                                          widget.cartMeal.mealName,
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
                                          '${(widget.cartMeal.mealPrice * numb).toStringAsFixed(2)} JD',
                                          style: Style1,
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
                                                    mealName: widget
                                                        .cartMeal.mealName,
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
                                            plus(numb);
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
                                                    "${widget.cartMeal.count}",
                                                    style: Style1,
                                                  )
                                                : Text(
                                                    "$numb",
                                                    style: Style1,
                                                  )),
                                      ),
                                    ),
                                    Positioned(
                                      right: 0,
                                      left: 50,
                                      bottom: 1,
                                      child: IconButton(
                                          icon: Icon(Icons.minimize),
                                          onPressed: () => minmize(numb)),
                                    ),
// Positioned(
//   width: 120,
//
//   child:   Row(
//     children: [
//       Container(
//         width: 32,
//         child: IconButton(
//                   icon: Icon(Icons.add),
//                   onPressed: () {
//                     plus(widget.cartMeal.count);
//                   }),
//       ),
//
//   Padding(
//     padding: const EdgeInsets.only(bottom:8.0,),
//     child: Container(
//
//       margin: EdgeInsets.only(left: 3),
//           height:37,width: 25,
//
//           decoration: BoxDecoration(
//            color: Colors.white, borderRadius: BorderRadius.circular(22)
//
//           ),
//           child: Center(child: Text("${widget.cartMeal.count}",style: Style1,)),
//         ),
//   ),
//   Container(
//     // margin: EdgeInsets.only(bottom: 3),//
//     child: IconButton(
//             icon: Icon(Icons.minimize),
//             onPressed: (){
//               print("Minimize");
//         }),
//   ),
//
//     ],
//   ),
// )
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

// class CartCard extends StatelessWidget {
//   final CartMeal cartMeal;
//
//   CartCard({this.cartMeal});
//
//   @override
//   Widget build(BuildContext context) {
//     print(cartMeal.mealName);
//     return Container(
//       child: Column(
//         children: [
//           Text(cartMeal.mealName),
//           Text('${cartMeal.mealPrice} JD'),
//           Image.network(cartMeal.mealImage),
//           Card(
//               child: Row(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.only(top:18.0,left: 12),
//                     child: FittedBox(
//                       child: Container(
//                         height: 130,
//                         width: 380,
//                         child: Material(
//                           borderRadius: (BorderRadius.circular(24.0)),
//                           elevation: 32.5,
//                           shadowColor: Colors.red,
//                           child: Row(
//                             children: [
//                               Container(
//                                 height: 100,
//                                 width: 100,
//                                 child: CircleAvatar(
//                                   radius: 20,
//                                   backgroundImage:NetworkImage(
//                                       "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTw5ytdZgaHr5ovnHQh9FKGit95zuXSVSmprAYbyzFJ7-JzaOMEpqhnIMGQw3Ib1cbOAJs&usqp=CAU"),
//
//                                 ),
//                               ),
//                               Column(
//
//                                 children: [
//
//                                   // Text("Food Name: ",style: Style1,),
//                                   Align(
//                                     alignment: Alignment.topLeft,
//                                     child: Container(
//                                       child: Text(
//                                         "burger",
//                                         style:Style1,
//
//                                       ),
//                                     ),
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.only(right: 50,left: 0.0,top: 12),
//                                     child: Row(
//
//                                       children: [
//                                         Text("Price: ",style: Style1,),
//                                         Text("${2.2}JD",
//                                           style:Style1,
//                                         ),
//
//                                       ],
//                                     ),
//                                   ),
//                                   Padding(padding: EdgeInsets.only(left: 20),
//                                     child: Row(
//                                       children: [
//                                         Container(
//                                           decoration: BoxDecoration(
//                                               borderRadius: (BorderRadius.circular(23)),
//                                               color: Colors.deepOrange),
//                                           child: IconButton(
//                                               icon: Icon(Icons.add),
//                                               onPressed: () => plus()),
//                                         ),
//                                         Padding(
//                                           padding: const EdgeInsets.only(left:18.0),
//                                           child: Container(
//
//                                               child:Text("${numb}",style: Style1)),
//                                         ),
//                                         Padding(
//                                           padding: const EdgeInsets.only(left :18.0),
//                                           child: Container(
//                                             decoration: BoxDecoration(
//                                                 borderRadius: (BorderRadius.circular(23)),
//                                                 color: Colors.deepOrange),
//                                             child: IconButton(
//                                                 icon: Icon(Icons.minimize),
//                                                 onPressed: () => minmize()),
//                                           ),
//                                         ),
//
//                                       ],
//                                     ),),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ))
//         ],
//       ),
//     );
//   }
// }
