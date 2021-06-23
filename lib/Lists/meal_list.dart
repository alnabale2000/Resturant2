import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resturant/firebase/firestore.dart';
import 'package:resturant/models/meal.dart';
import 'package:resturant/views/user_pages/meal_details.dart';
import 'package:resturant/globals.dart' as globals;

class MealList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final meals = Provider.of<List<Meal>>(context);
    return ListView.builder(
      shrinkWrap: true,
      itemCount: meals?.length ?? 0,
      itemBuilder: (context, index) {
        return MealCard(
          meal: meals[index],
        );
      },
    );
  }
}

class MealCard extends StatefulWidget {
  final Meal meal;

  MealCard({this.meal});

  @override
  _MealCardState createState() => _MealCardState();
}

class _MealCardState extends State<MealCard> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User logedInUser;

  String uid;

  String isAdmin = '';

  void adminCheck() async {
    try {
      final user = _auth.currentUser;

      if (user != null) logedInUser = user;

      uid = logedInUser.uid;

      var userData =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      setState(() {
        isAdmin = userData.data()['admin'];
      });
    } catch (e) {
      print('failed');
    }
  }

  @override
  void initState() {
    super.initState();
    adminCheck();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        child: Container(
          child: Column(
            children: [
              FittedBox(
                child: Container(
                  padding: EdgeInsets.only(top: 7),
                  width: 400,
                  child: Material(
                    borderRadius: (BorderRadius.circular(14.0)),
                    elevation: 32.5,
                    shadowColor: Colors.deepOrange,
                    child: Row(
                      children: [
                        widget.meal.mealImage == 'No image'
                            ? Container(
                                width: 180,
                                height: 130,
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(14),
                                    topLeft: Radius.circular(14),
                                  ),
                                ),
                                child: Center(
                                  child:
                                      Icon(Icons.image_not_supported_rounded),
                                ),
                              )
                            : Container(
                                height: 130,
                                width: 180,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(14),
                                    topLeft: Radius.circular(14),
                                  ),
                                  child: Image(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(widget.meal.mealImage),
                                  ),
                                ),
                              ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${widget.meal.mealName}',
                                maxLines: 2,
                                softWrap: false,
                                overflow: TextOverflow.fade,
                                style: TextStyle(
                                  color: Colors.deepOrange,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 20),
                              Text(
                                '${widget.meal.mealPrice} JD ',
                                style: TextStyle(
                                    color: Colors.deepOrange,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        Spacer(),
                        globals.userCheck == 'true'
                            ? IconButton(
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.deepOrange,
                                ),
                                onPressed: () {
                                  FireStoreService().deleteSingleMealDocument(
                                    mealName: widget.meal.mealName,
                                    collectionName: Provider.of<String>(context,
                                        listen: false),
                                  );
                                },
                              )
                            : Container(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MealDetails(
                meal: widget.meal,
              ),
            ),
          );
        },
      ),
    );
  }
}
