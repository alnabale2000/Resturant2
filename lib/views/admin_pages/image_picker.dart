import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:resturant/common_components/loading.dart';
import 'package:resturant/views/admin_pages/add_category.dart';
import 'package:resturant/views/admin_pages/add_meal.dart';

class ImageCapture extends StatefulWidget {
  createState() => _ImageCaptureState();
  final String from;

  ImageCapture(this.from);
}

class _ImageCaptureState extends State<ImageCapture> {
  File _imageFile;

  Future<void> _pickImage(ImageSource source) async {
    PickedFile selected = await ImagePicker().getImage(source: source);

    setState(() {
      _imageFile = File(selected.path);
    });
  }

  void _clear() {
    setState(() => _imageFile = null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back,
            color: Colors.green,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomAppBar(
        color: Colors.green,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.photo_camera),
              onPressed: () => _pickImage(ImageSource.camera),
            ),
            IconButton(
              icon: Icon(Icons.photo_library),
              onPressed: () => _pickImage(ImageSource.gallery),
            ),
          ],
        ),
      ),

      // Preview the image and crop it
      body: ListView(
        children: <Widget>[
          if (_imageFile != null) ...[
            Image.file(_imageFile),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                child: Icon(Icons.refresh, color: Colors.green),
                onPressed: _clear,
              ),
            ),
            SizedBox(height: 10),
            Uploader(file: _imageFile, from: widget.from)
          ]
        ],
      ),
    );
  }
}

class Uploader extends StatefulWidget {
  final File file;
  final String from;

  Uploader({this.file, this.from, Key key}) : super(key: key);
  @override
  _UploaderState createState() => _UploaderState();
}

class _UploaderState extends State<Uploader> {
  UploadTask _uploadTask;

  final FirebaseStorage _storage =
      FirebaseStorage.instanceFor(bucket: 'gs://resturant-bfabe.appspot.com');

  void _startUpload() {
    String filePath = 'images/${DateTime.now()}.png';

    setState(() {
      _uploadTask = _storage.ref().child(filePath).putFile(widget.file);
    });
  }

  String url;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    if (_uploadTask != null) {
      return StreamBuilder(
        stream: _uploadTask.snapshotEvents,
        builder: (_, snapshot) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Loading(),
          );
        },
      );
    } else {
      // Allows user to decide when to start the upload
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 120),
            child: Container(
              decoration: BoxDecoration(color: Colors.green, boxShadow: [
                BoxShadow(
                  offset: Offset(0, 2),
                  color: Colors.green,
                  blurRadius: 4,
                  spreadRadius: -1,
                )
              ]),
              child: TextButton.icon(
                label: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'SAVE',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                icon: Icon(
                  Icons.save,
                  color: Colors.white,
                ),
                onPressed: () async {
                  setState(() {
                    loading = true;
                  });
                  _startUpload();

                  TaskSnapshot taskSnapshot = await _uploadTask;
                  url = (await taskSnapshot.ref.getDownloadURL()).toString();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => widget.from == 'category'
                          ? AddCategory(
                              file: widget.file,
                              url: url,
                            )
                          : AddMeal(
                              file: widget.file,
                              url: url,
                            ),
                    ),
                  );
                },
              ),
            ),
          ),
          SizedBox(height: 10)
        ],
      );
    }
  }
}
