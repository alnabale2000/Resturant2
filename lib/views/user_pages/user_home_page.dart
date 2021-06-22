import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resturant/common_components/loading.dart';
import 'package:resturant/firebase/firestore.dart';
import 'package:resturant/models/category.dart';
import 'package:resturant/random_states.dart';
import 'package:resturant/views/common_pages/log_in.dart';
import 'cart_page.dart';
import 'file:///C:/Users/NTC/AndroidStudioProjects/resturant/lib/user_components/sliver_header_delegate.dart';
import 'package:resturant/views/user_pages/meals.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:resturant/globals.dart' as globals;

class UserHomePage extends StatefulWidget {
  @override
  _UserHomePageState createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage>
    with SingleTickerProviderStateMixin {
  bool loading = false;
  int i = 0;
  List<String> _images = [];
  SwiperController _swiperController;

  @override
  void initState() {
    super.initState();
    filledImage();

    _swiperController = SwiperController();
    _swiperController.startAutoplay();
  }

  @override
  void dispose() {
    super.dispose();
    _swiperController.stopAutoplay();
    _swiperController.dispose();
  }

  var carsulCounter;
  filledImage() {
    _images.add('images/food.jpg');
    _images.add('images/food1.jpg');
    _images.add('images/food2.jpg');
    _images.add('images/food3.jpg');
    _images.add('images/food4.jpg');
    _images.add('images/food5.jpg');
    _images.add('images/food6.jpg');
    _images.add('images/food7.jpg');
  }

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    print('test1');
    final categories = Provider.of<List<Category>>(context);
    // final randomState = Provider.of<RandomStates>(context, listen: false);
    // randomState.adminCheck();
    print(globals.userCheck);

    List<Tab> tabBarItems = [];

    if (categories != null)
      for (Category category in categories) {
        tabBarItems.add(
          Tab(
            text: category.name,
            icon: globals.userCheck == 'true'
                ? GestureDetector(
                    child: Icon(Icons.delete),
                    onTap: () {
                      FireStoreService().deleteSingleCategoryDocument(
                          categoryName: category.name);
                    },
                  )
                : SizedBox(height: 0, width: 0),
          ),
        );
      }

    return categories == null
        ? Loading()
        : DefaultTabController(
            length: categories?.length ?? 0,
            child: Scaffold(
              key: _scaffoldKey,
              backgroundColor: Colors.white,
              endDrawer: Drawer(),
              appBar: AppBar(
                iconTheme: IconThemeData(color: Colors.deepOrange[400]),
                leading: globals.userCheck == 'true'
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
                  'Restaurant Name',
                  style: TextStyle(
                    color: Colors.deepOrange[400],
                    fontSize: 22.5,
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
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Cart()));
                    },
                  ),
                  // IconButton(
                  //   icon: Icon(
                  //     Icons.account_box_outlined,
                  //     color: Colors.deepOrange[400],
                  //   ),
                  //   onPressed: () {
                  //     Navigator.push(context,
                  //         MaterialPageRoute(builder: (context) => LogIn()));
                  //   },
                  // ),
                  IconButton(
                      icon: Icon(Icons.menu),
                      onPressed: () {
                        _scaffoldKey.currentState.openEndDrawer();
                      }),
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
                                controller: _swiperController,
                                itemCount: _images.length,
                                onIndexChanged: (i) {
                                  setState(() {
                                    carsulCounter = i;
                                  });
                                },
                                itemBuilder:
                                    (BuildContext context, int index) =>
                                        Image.asset(
                                  _images[index],
                                  fit: BoxFit.cover,
                                ),
                                autoplay: false,
                                loop: false,
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
                                                            100),
                                                  ),
                                                )
                                              : Container(
                                                  margin: EdgeInsets.all(5),
                                                  width: 12,
                                                  height: 12,
                                                  decoration: BoxDecoration(
                                                    color: Colors.grey[300],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100),
                                                  ),
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
