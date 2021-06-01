import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
          padding: const EdgeInsets.all(50.0),
          child: Center(
            child: ListView(
              children: [
                TextButton(
                  child: Container(
                    height: size.height * 0.3,
                    color: Colors.grey[300],
                    child: Center(
                      child: Icon(
                        Icons.add_a_photo_outlined,
                        color: Colors.green,
                      ),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ImageCapture()));
                  },
                ),
                SizedBox(
                  height: size.height * 0.05,
                ),
                RoundedInputField(
                  color: Colors.green,
                  icon: Icons.list_alt,
                  hintText: 'اسم القسم',
                  onChanged: (val) {
                    categoryName = val;
                  },
                ),
                SizedBox(height: size.height * 0.15),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.green,
                  ),
                  child: TextButton(
                    onPressed: () async {
                      FireStoreService().addCategory('image23', categoryName);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => AddMeal()));
                    },
                    child: Text(
                      'اضافة',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
