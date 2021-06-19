import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resturant/firebase/firestore.dart';
import 'package:resturant/models/meal.dart';
import 'package:resturant/random_states.dart';

class MealDetails extends StatefulWidget {
  final Meal meal;

  MealDetails({this.meal});

  @override
  _MealDetailsState createState() => _MealDetailsState();
}

class _MealDetailsState extends State<MealDetails> {
  int counter = 1;
  // double prices = 0.0;
  // double price;

  //
  // method() {
  //   setState(() {
  //     price = _meal.mealPrice;
  //     prices = _meal.mealPrice;
  //   });
  // }

  // String ChooseString;
  // // List listItem = [
  // //   "Item1",
  // //   "Item2",
  // //   "Item3",
  // //   "Item4",
  // //   "Item5",
  // //   "Item6",
  // // ];

  plus() {
    setState(() {
      counter = counter + 1;

      //    prices = numb * price;
    });
  }

  minmize() {
    if (counter > 0) {
      setState(() {
        counter = counter - 1;

//        prices = numb * price;
      });
    } else
      counter = 0;
  }

  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();

  @override
  Widget build(BuildContext context) {
    final randomState = Provider.of<RandomStates>(context, listen: false);
    final _meal = widget.meal;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.deepOrange[400]),
        backgroundColor: Colors.white,
        title: Text(
          _meal.mealName,
          style: TextStyle(color: Colors.deepOrange[400]),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              height: 270,
              width: double.infinity,
              child: Image(
                fit: BoxFit.fill,
                image: NetworkImage(
                  _meal.mealImage,
                ),
              ),
            ),

            Center(
              child: Container(
                child: Text(
                  _meal.mealName,
                  style: TextStyle(
                      color: Colors.black87,
                      fontSize: 32,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),

            Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "   Price : ",
                    style: TextStyle(fontSize: 22, color: Colors.black87),
                  ),
                  Container(
                    child: Text(
                      "${(_meal.mealPrice * counter).toStringAsFixed(2)} JD",
                      style: TextStyle(color: Colors.black87, fontSize: 22),
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: Container(
                child: Text(
                  "التفاصيل",
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 22,
                  ),
                ),
              ),
            ),
            SizedBox(height: 15),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: (BorderRadius.circular(23)),
                        color: Colors.deepOrange),
                    child: IconButton(
                      icon: Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                      onPressed: () => plus(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Container(
                    child: Text(
                      '$counter',
                      style: TextStyle(color: Colors.deepOrange, fontSize: 22),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: (BorderRadius.circular(23)),
                        color: Colors.deepOrange),
                    child: IconButton(
                        icon: Icon(
                          Icons.minimize,
                          color: Colors.white,
                        ),
                        onPressed: () => minmize()),
                  ),
                ),
              ],
            ),
            // Center(
            //   child: Container(
            //     decoration: BoxDecoration(
            //
            //     ),
            //       child: DropdownButton(
            //         isExpanded: true,
            //     hint: Text("الاضافات"),
            //     value: ChooseString,
            //     onChanged: (newValue) {
            //       setState(() {
            //         // ChooseString = newValue;
            //       });
            //     },
            //     items: listItem.map((ValueItem) {
            //       return DropdownMenuItem(
            //           value: ValueItem,
            //           child: Row(
            //             children: [
            //               // CheckboxListTile(
            //               //   value: value1,
            //               //   onChanged: onChange1,
            //               //   subtitle: Text(ValueItem),
            //               //   title: new Text("Cheese",
            //               //       style: TextStyle(
            //               //           color: Colors.white,
            //               //           fontSize: 17,
            //               //           fontWeight: FontWeight.bold)),
            //               //   activeColor: Colors.black87,
            //               // ),
            //
            //             ],
            //           ));
            //     }).toList(),
            //   )
            //
            //       // Row(
            //       //   crossAxisAlignment: CrossAxisAlignment.center,
            //       //   mainAxisAlignment: MainAxisAlignment.end,
            //       //   children: [
            //       //     Container( child: Text("${_meal.mealPrice} JD",style: TextStyle(color: Colors.black87,fontSize: 22),)),
            //       //
            //       //     Text(" : العدد  ",style: TextStyle(fontSize: 22,color: Colors.black87),),
            //       //
            //       //   ],
            //       // ),
            //       ),
            // ),
          ],
        ),
      ),
      floatingActionButton: FlipCard(
        direction: FlipDirection.VERTICAL, // default

        key: cardKey,
        front: Container(
          width: double.infinity,
          height: 70,
          child: FloatingActionButton(
            onPressed: () {
              FireStoreService().addToUserCart(
                uid: randomState.getCurrentUser(),
                mealName: _meal.mealName,
                mealPrice: _meal.mealPrice,
                mealDetails: _meal.mealDetails,
                mealImage: _meal.mealImage,
                count: counter,
                totalPrice: _meal.mealPrice * counter,
              );
              cardKey.currentState.toggleCard();
            },
            child: Text(
              'Add To Cart',
              style: TextStyle(fontSize: 20),
            ),
            isExtended: true,
          ),
        ),
        back: Container(
          width: double.infinity,
          color: Colors.deepOrange[400],
          height: 70,
          child: Center(
            child: Text(
              'Added To Cart Successfully',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
