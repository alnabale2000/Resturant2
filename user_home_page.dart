import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resturant/common_components/loading.dart';
import 'package:resturant/models/category.dart';
import 'package:resturant/views/admin_pages/admin_homepage.dart';
import 'package:resturant/views/common_pages/log_in.dart';
import 'package:resturant/views/user_pages/meals.dart';

class UserHomePage extends StatelessWidget {
  List<Tab> tabBarItems = [];

  bool loading = false;
  int i = 0;

  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<List<Category>>(context, listen: false);

    if (categories != null)
      for (Category category in categories) {
        tabBarItems.add(Tab(text: category.name));
      }

    return categories == null
        ? Loading()
        : DefaultTabController(
            length: categories?.length ?? 0,
            child: Scaffold(
              backgroundColor: Colors.white,
              body: NestedScrollView(
                headerSliverBuilder: (context, value) {
                  return [
                    SliverAppBar(
                      elevation: 4,
                      actions: [
                        IconButton(
                            icon: Icon(Icons.account_box_outlined),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LogIn()));
                            })
                      ],
                      leading: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          size: 25,
                          color: Colors.white,
                        ),
                      ),
                      floating: true,
                      pinned: true,
                      expandedHeight: 110,
                      backgroundColor: Colors.green,
                      bottom: TabBar(
                        isScrollable: true,
                        tabs: tabBarItems,
                      ),
                    ),
                  ];
                },
                body: TabBarView(
                  children: tabBarItems.map((Tab tab) {
                    return Meals(tab.text);
                  }).toList(),
                ),
              ),
            ),
          );
  }
}
