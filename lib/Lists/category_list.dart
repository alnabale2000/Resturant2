import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:resturant/models/category.dart';
import 'package:resturant/random_states.dart';
import 'package:resturant/views/user_pages/meals.dart';

class CategoryList extends StatelessWidget {
  final bool isGroupButton;

  CategoryList({this.isGroupButton = false});

  int value;
  String chosenCollection;
  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<List<Category>>(context);
    final randomState = Provider.of<RandomStates>(context, listen: false);
    return ListView.builder(
      shrinkWrap: true,
      itemCount: categories?.length ?? 0,
      itemBuilder: (context, index) {
        return isGroupButton
            ? RadioListTile(
                title: Text(categories[index].name),
                value: index,
                groupValue: randomState.radioValue,
                onChanged: (i) {
                  randomState.getRadioValue(i);
                  randomState
                      .getCategoryName(categories[randomState.radioValue].name);
                },
              )
            : CategoryCard(
                category: categories[index],
                index: index,
              );
      },
    );
  }
}

class CategoryCard extends StatelessWidget {
  final Category category;
  final int index;

  CategoryCard({this.category, this.index});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          color: Colors.green,
          height: size.height * 0.25,
          width: size.width * 0.43,
          child: Column(
            children: [
              Text(category.name),
              Expanded(
                child: Image.network(
                  category.image,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Meals(category.name)));
      },
    );
  }
}
