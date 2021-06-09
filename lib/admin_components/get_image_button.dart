import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resturant/views/admin_pages/image_picker.dart';

class GetImageButton extends StatelessWidget {
  GetImageButton({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<String>(context);
    return TextButton(
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
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ImageCapture(data)));
      },
    );
  }
}
