import 'package:cloud_firestore/cloud_firestore.dart';

class Category {
  final String image;
  final String name;

  Category({this.image, this.name});

  factory Category.fromFireStore(DocumentSnapshot doc) {
    Map data = doc.data();
    return Category(
      image: data['image_url'] ?? 'No image',
      name: data['category_name'] ?? 'No name',
    );
  }
}
