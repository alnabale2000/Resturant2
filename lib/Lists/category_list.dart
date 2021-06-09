import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resturant/common_components/loading.dart';
import 'package:resturant/models/category.dart';

class CategoryList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<List<Category>>(context);
    return ListView.builder(
      itemCount: categories?.length ?? 0,
      itemBuilder: (context, index) {
        return CategoryCard(
          category: categories[index],
        );
      },
    );
  }
}

class CategoryCard extends StatefulWidget {
  final Category category;

  CategoryCard({this.category});

  @override
  _CategoryCardState createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  List<String> data = [];

  @override
  void initState() {
    fillData();
    printt();
  }

  fillData() {
    data.add(widget.category.name);
  }

  void printt() {
    for (String s in data) {
      print(s);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(widget.category.name),
        Image.network(widget.category.image == 'image23'
            ? 'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/1200px-Image_created_with_a_mobile_phone.png'
            : widget.category.image),
      ],
    );
  }
}
