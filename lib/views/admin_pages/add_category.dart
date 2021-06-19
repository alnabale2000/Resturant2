import 'dart:io' show File;

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:resturant/admin_components/get_image_button.dart';
import 'file:///C:/Users/NTC/AndroidStudioProjects/resturant/lib/common_components/input_field.dart';
import 'package:resturant/firebase/firestore.dart';
import 'package:resturant/views/admin_pages/add_meal.dart';

class AddCategory extends StatelessWidget {
  final String url;
  final File file;

  AddCategory({this.url, this.file});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String categoryName;

  @override
  Widget build(BuildContext context) {
    print('test2');
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                ///Start The top small box
                Container(
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                Positioned(
                  top: -20,
                  left: size.width / 2.5,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.blue,
                    ),
                    height: 50,
                    width: 50,
                    child: Image.network(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQcof3pIm8ZLI0NMZKT7T47CuANQmWvSzd8EA&usqp=CAU',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                ///End The top small box

                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 50, horizontal: 30),
                  child: Center(
                    child: ListView(
                      children: [
                        file != null
                            ? Image.file(
                                file,
                                height: size.height * 0.3,
                              )
                            : GetImageButton(
                                size: size,
                                from: 'category',
                              ),
                        SizedBox(
                          height: size.height * 0.05,
                        ),
                        RoundedInputField(
                          validator: (String val) =>
                              val.isEmpty ? 'اسم القسم مطلوب' : null,
                          backGroundColor: Colors.white,
                          color: Colors.green,
                          icon: Icons.list_alt,
                          hintText: 'اسم القسم',
                          onChanged: (val) {
                            categoryName = val;
                          },
                        ),
                        SizedBox(height: size.height * 0.07),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                          ),
                          child: TextButton(
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                FireStoreService()
                                    .addCategory(url, categoryName);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AddMeal()));
                              }
                            },
                            child: Text(
                              'اضافة',
                              style: TextStyle(color: Colors.green),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
