import 'package:flutter/material.dart';
import 'package:resturant/firebase/auth.dart';
import 'package:resturant/views/common_pages/log_in.dart';
import 'package:resturant/globals.dart' as globals;
import 'package:resturant/views/user_pages/home_page.dart';

class UserHomePageDrawer extends StatefulWidget {
  @override
  _UserHomePageDrawerState createState() => _UserHomePageDrawerState();
}

class _UserHomePageDrawerState extends State<UserHomePageDrawer> {
  @override
  Widget build(BuildContext context) {
    print(' DRAWER TEST ${globals.userCheck}');
    return Drawer(
      child: Container(
        color: Colors.white,
        child: ListView(
          children: [
            DrawerHeader(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.deepOrange[400],
                    border: Border.all(color: Colors.green[400], width: 2.5),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                      bottomLeft: Radius.circular(15),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'LOGO',
                      style: TextStyle(color: Colors.white, fontSize: 30),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            DrawerItem(
              text: 'About us',
              icon: Icons.account_box_outlined,
            ),
            DrawerItem(
              text: 'Our Location',
              icon: Icons.location_on_outlined,
            ),
            DrawerItem(
              text: 'Rate Us',
              icon: Icons.star,
            ),
            DrawerItem(
              text: 'Language',
              icon: Icons.language,
            ),
            DrawerItem(
              text: 'Call Us',
              icon: Icons.call,
            ),
            DrawerItem(
              text: globals.userCheck == '' ? 'Log in' : 'log out',
              icon: globals.userCheck == '' ? Icons.login : Icons.logout,
              function: () async {
                print('1 click drawer test');
                if (globals.userCheck == '') {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LogIn()));
                } else {
                  setState(() {
                    globals.setAdminValue('');
                  });
                  await Auth().signOut();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomePage()));
                  print('2 click drawer test');
                }
              },
            )
          ],
        ),
      ),
    );
  }
}

class DrawerItem extends StatelessWidget {
  final String text;
  final Function function;
  final IconData icon;

  DrawerItem({this.text, this.function, this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 1.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: ListTile(
          leading: Icon(
            icon,
            size: 29,
            color: Colors.green[400],
          ),
          title: Text(
            text ?? 'Coming soon',
            style: TextStyle(color: Colors.deepOrange[400], fontSize: 22),
          ),
          onTap: function,
        ),
      ),
    );
  }
}
