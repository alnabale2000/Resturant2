import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resturant/facebook.dart';
import 'package:resturant/firebase/firestore.dart';
import 'package:resturant/random_states.dart';
import 'package:resturant/wrapper.dart';

import 'views/admin_pages/add_meal.dart';

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
        // StreamProvider.value(value: FireStoreService().meals),
        ChangeNotifierProvider(create: (_) => RandomStates())
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.orange,
          textTheme: TextTheme(
            bodyText1: TextStyle(),
            bodyText2: TextStyle(),
          ),
        ),
        home: SafeArea(child: Wrapper()),
      ),
    );
  }
}
