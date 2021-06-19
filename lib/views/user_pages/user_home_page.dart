import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resturant/common_components/loading.dart';
import 'package:resturant/firebase/firestore.dart';
import 'package:resturant/models/category.dart';
import 'package:resturant/random_states.dart';
import 'package:resturant/views/common_pages/log_in.dart';
import 'file:///C:/Users/NTC/AndroidStudioProjects/resturant/lib/user_components/sliver_header_delegate.dart';
import 'package:resturant/views/user_pages/meals.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class UserHomePage extends StatefulWidget {
  @override
  _UserHomePageState createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage>
    with SingleTickerProviderStateMixin {
  bool loading = false;
  int i = 0;
  List<String> _images = [];

  @override
  void initState() {
    super.initState();
    filledImage();
  }

  var carsulCounter;
  filledImage() {
    _images.add(
        "https://www.recipetineats.com/wp-content/uploads/2014/12/Chicken-Shawarma_5.jpg");
    _images.add(
        "https://amiraspantry.com/wp-content/uploads/2020/11/beef-shawarma-recipe-IG.jpg");
    _images.add(
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTbFh_JMTYBId3X1Xs0PPS5CPR7aNVNpKeTBw&usqp=CAU");
    _images.add(
        "https://images.immediate.co.uk/production/volatile/sites/30/2020/08/swedish-meatball-burgers-e01dcfe.jpg?quality=90&webp=true&resize=440,400");

    _images.add(
        "https://hips.hearstapps.com/hmg-prod/images/190416-chicken-burger-082-1556204252.jpg");
    _images.add(
        "https://sifu.unileversolutions.com/image/en-LK/recipe-topvisual/2/1260-709/crispy-fried-chicken-burger-50388014.jpg");
    _images.add(
        "https://blog.fitbit.com/wp-content/uploads/2017/03/Beet-Pizza_blog.jpg");
    _images.add(
        "https://blog.fitbit.com/wp-content/uploads/2017/03/Beet-Pizza_blog.jpg");
  }

  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<List<Category>>(context);
    final randomState = Provider.of<RandomStates>(context);
    randomState.adminCheck();
    List<Tab> tabBarItems = [];

    if (categories != null)
      for (Category category in categories) {
        tabBarItems.add(
          Tab(
            text: category.name,
            icon: randomState.isAdmin == 'true'
                ? GestureDetector(
                    child: Icon(Icons.delete),
                    onTap: () {
                      FireStoreService().deleteSingleCategoryDocument(
                          categoryName: category.name);
                    },
                  )
                : null,
          ),
        );
      }
    return categories == null
        ? Loading()
        : DefaultTabController(
            length: categories?.length ?? 0,
            child: Scaffold(
              backgroundColor: Colors.white,
              drawer: Drawer(),
              appBar: AppBar(
                iconTheme: IconThemeData(color: Colors.deepOrange[400]),
                leading: randomState.isAdmin == 'true'
                    ? IconButton(
                        icon: Icon(Icons.arrow_back),
                        color: Colors.deepOrange,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      )
                    : null,
                elevation: 2.5,
                centerTitle: true,
                title: Text(
                  'Al-tazj',
                  style: TextStyle(
                    color: Colors.deepOrange[400],
                    fontFamily: 'Pacifico',
                  ),
                ),
                backgroundColor: Colors.white,
                actions: [
                  IconButton(
                    icon: Icon(
                      Icons.local_grocery_store,
                      color: Colors.deepOrange[400],
                    ),
                    color: Colors.deepOrange[400],
                    onPressed: () {
                      // Navigator.push(context, MaterialPageRoute(builder: (context)=>CartPage()));
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.account_box_outlined,
                      color: Colors.deepOrange[400],
                    ),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => LogIn()));
                    },
                  )
                ],
              ),
              body: NestedScrollView(
                headerSliverBuilder: (context, value) {
                  return [
                    Container(
                      child: SliverGrid.extent(
                        // crossAxisCount: 1,
                        maxCrossAxisExtent: 700,

                        childAspectRatio: 2.0,
                        children: <Widget>[
                          Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              Swiper(
                                itemCount: _images.length,
                                onIndexChanged: (i) {
                                  setState(() {
                                    carsulCounter = i;
                                  });
                                },
                                itemBuilder:
                                    (BuildContext context, int index) =>
                                        Image.network(
                                  _images[index],
                                  fit: BoxFit.cover,
                                ),
                                autoplay: true,
                              ),
                              Container(
                                // color: Colors.green,
                                width: 190,
                                height: 40,
                                alignment: Alignment.bottomCenter,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: _images.length,
                                  // itemCount: 10,
                                  itemBuilder: (context, index) {
                                    return Align(
                                      alignment: Alignment.center,
                                      child: Container(
                                        alignment: Alignment.bottomCenter,
                                        child:
                                            //4 ==0
                                            Center(
                                          child: carsulCounter == index
                                              ? Container(
                                                  margin: EdgeInsets.all(5),
                                                  width: 15,
                                                  height: 15,
                                                  decoration: BoxDecoration(
                                                      color: Colors.green,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              100)),
                                                )
                                              : Container(
                                                  margin: EdgeInsets.all(5),
                                                  width: 12,
                                                  height: 12,
                                                  decoration: BoxDecoration(
                                                      color: Colors.grey[300],
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              100)),
                                                ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SliverPersistentHeader(
                      floating: true,
                      pinned: true,
                      delegate: SliverHeaderDelegate(
                        color: Colors.white,
                        tabBar: TabBar(
                          labelStyle: TextStyle(
                            fontSize: 20.0,
                            fontFamily: 'Pacifico',
                          ), //For Selected tab
                          labelColor: Colors.deepOrange[400],
                          isScrollable: true,
                          tabs: tabBarItems,
                        ),
                      ),
                    ),
                  ];
                },
                body: TabBarView(
                  children: tabBarItems.map((Tab tab) {
                    return Meals(
                      categoryName: tab.text,
                    );
                  }).toList(),
                ),
              ),
            ),
          );
  }
}
