import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:resturant/models/meal.dart';

class MealDetails extends StatefulWidget {
  final Meal meal;

  MealDetails({this.meal});

  @override
  _MealDetailsState createState() => _MealDetailsState();
}

class _MealDetailsState extends State<MealDetails> {
  int numb = 1;
  // double prices = 0.0;
  // double price;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //  method();
  }
  //
  // method() {
  //   setState(() {
  //     price = widget.meal.mealPrice;
  //     prices = widget.meal.mealPrice;
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
      numb = numb + 1;

      //    prices = numb * price;
    });
  }

  minmize() {
    if (numb > 0) {
      setState(() {
        numb = numb - 1;

//        prices = numb * price;
      });
    } else
      numb = 0;
  }

  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.meal.mealName,
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
                  widget.meal.mealImage,
                ),
              ),
            ),

            Center(
              child: Container(
                child: Text(
                  widget.meal.mealName,
                  style: TextStyle(
                      color: Colors.green,
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
                  Container(
                      child: Text(
                    "${(widget.meal.mealPrice * numb).toStringAsFixed(2)} JD",
                    style: TextStyle(color: Colors.green, fontSize: 22),
                  )),
                  Text(
                    " :  السعر  ",
                    style: TextStyle(fontSize: 22, color: Colors.green),
                  ),
                ],
              ),
            ),
            Center(
                child: Container(
                    child: Text(
              "التفاصيل",
              style: TextStyle(
                  color: Colors.green,
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
            ))),

            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: (BorderRadius.circular(23)),
                        color: Colors.green),
                    child: IconButton(
                        icon: Icon(Icons.add), onPressed: () => plus()),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Container(
                    child: Text(
                      "$numb",
                      style: TextStyle(color: Colors.deepOrange, fontSize: 22),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: (BorderRadius.circular(23)),
                        color: Colors.green),
                    child: IconButton(
                        icon: Icon(Icons.minimize), onPressed: () => minmize()),
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
            //               //   activeColor: Colors.green,
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
            //       //     Container( child: Text("${widget.meal.mealPrice} JD",style: TextStyle(color: Colors.green,fontSize: 22),)),
            //       //
            //       //     Text(" : العدد  ",style: TextStyle(fontSize: 22,color: Colors.green),),
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
              print("تأكيد");
              cardKey.currentState.toggleCard();
            },
            child: Text("تاكيد الطلب"),
            isExtended: true,
          ),
        ),
        back: Container(
          width: double.infinity,
          height: 70,
          child: FloatingActionButton(
            child: Text('تمت اضافة الطلب الى السلة'),
            isExtended: true,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
