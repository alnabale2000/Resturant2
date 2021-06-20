import 'package:flutter/material.dart';
import 'package:resturant/firebase/auth.dart';
import 'package:resturant/views/user_pages/cart_page.dart';
import 'package:resturant/views/user_pages/user_home_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final _tabs = [
    UserHomePage(),
    Cart(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _tabs[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            // gradient: LinearGradient(
            //   colors: [Colors.deepOrange[400], Colors.green],
            //   begin: Alignment.topLeft,
            //   end: Alignment.topRight,
            //   stops: [0.0, 0.8],
            //   tileMode: TileMode.clamp,
            // ),
            ),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          selectedFontSize: 22,
          unselectedItemColor: Colors.white,
          selectedItemColor: Colors.orange,
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'الرئيسية',
              backgroundColor: Colors.deepOrange,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart_rounded),
              label: 'المشتريات',
              backgroundColor: Colors.deepOrange,
            ),
          ],
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}
