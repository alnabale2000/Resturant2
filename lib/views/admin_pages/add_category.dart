import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:resturant/admin_components/get_image_button.dart';
import 'package:resturant/admin_components/input_field.dart';
import 'package:resturant/firebase/firestore.dart';
import 'package:resturant/views/admin_pages/add_meal.dart';
import 'package:resturant/views/admin_pages/image_picker.dart';

class AddCategory extends StatelessWidget {
  String categoryName;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('اضافة قسم'),
        backgroundColor: Colors.green,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              ///Start The top small box

              Container(
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(20)),
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
                      GetImageButton(size: size),
                      SizedBox(
                        height: size.height * 0.05,
                      ),
                      RoundedInputField(
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
                            FireStoreService()
                                .addCategory('image23', categoryName);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AddMeal()));
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
    );
  }
}
