import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resturant/firebase/firestore.dart';
import 'package:resturant/random_states.dart';
import 'package:resturant/views/user_pages/cart_page.dart';
import 'package:resturant/views/user_pages/home_page.dart';
import 'package:resturant/wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider.value(value: FireStoreService().categories),
        ChangeNotifierProvider(create: (_) => RandomStates()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.deepOrange,
          textTheme: TextTheme(
            bodyText1: TextStyle(fontFamily: 'Pacifico'),
            bodyText2: TextStyle(fontFamily: 'Pacifico'),
          ),
        ),
        home: SafeArea(child: Cart()), //Cart()
      ),
    );
  }
}
