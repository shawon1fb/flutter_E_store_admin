import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:image_picker/image_picker.dart';

import 'log.dart';

///flutter_native_image: ^0.0.5

class FlutterImagePicker {
  static Future<File> compressImage(File imageFile) async {
    if (imageFile == null) return null;
    File image;
    try {
      image = await FlutterNativeImage.compressImage(imageFile.path,
          quality: 80, percentage: 80);
    } catch (e) {
      L.log(e);
    }
    return image ?? null;
  }

  static Future retrieveLostData() async {
    // ignore: deprecated_member_use
    final LostDataResponse response = await ImagePicker.retrieveLostData();
    if (response == null) {
      return;
    }
    if (response.file != null) {
      if (response.type == RetrieveType.image) {
        return (response.file);
      }
    } else {
      // print((response.exception));
    }
    return;
  }

  static Future<File> getImageGallery(context, {bool compress = false}) async {
    // ignore: deprecated_member_use
    File _image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 100);
    File temp;
    try {
      temp = await retrieveLostData();
      if (temp != null) _image = temp;
    } catch (e) {
      print(e);
    }

    if (compress == true) {
      try {
        File _tempImage = await compressImage(_image);
        Navigator.of(context).pop();
        return _tempImage;
      } catch (e) {
        Navigator.of(context).pop();
        return _image;
      }
    }
    Navigator.of(context).pop();
    return _image;
  }

  static Future<File> getImageCamera(context, {bool compress = false}) async {
    // ignore: deprecated_member_use
    File _image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 100);
    File temp;
    try {
      temp = await retrieveLostData();
      if (temp != null) _image = temp;
    } catch (e) {
      print(e);
    }

    if (compress == true) {
      try {
        File _tempImage = await compressImage(_image);
        Navigator.of(context).pop();
        return _tempImage;
      } catch (e) {
        Navigator.of(context).pop();
        return _image;
      }
    }
    Navigator.of(context).pop();
    return _image;
  }

  static void imagePickerModalSheet(
      {BuildContext context, Function fromGallery, Function fromCamera}) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      isDismissible: true,
      context: context,
      builder: (builder) {
        return DraggableScrollableSheet(
          initialChildSize: 0.3,
          maxChildSize: 1,
          minChildSize: 0.3,
          builder: (BuildContext context, ScrollController scrollController) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    // pick from Gallery
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      width: double.infinity,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'CHOOSE FOR ACTION',
                          // ignore: deprecated_member_use
                          style: Theme.of(context).textTheme.body1.copyWith(
                              fontSize: 12.0,
                              fontWeight: FontWeight.normal,
                              color: Colors.grey),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 24,
                    ),

                    Container(
                      padding: EdgeInsets.all(5),
                      width: double.infinity,
                      child: Row(
                        children: <Widget>[
                          SizedBox(
                            width: 30,
                          ),
                          Column(
                            children: <Widget>[
                              InkWell(
                                onTap: fromGallery,
                                child: Container(
                                  decoration:
                                      BoxDecoration(shape: BoxShape.circle),
                                  child: Material(
                                    elevation: 6,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(22.0)),
                                    child: Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                            image: AssetImage(
                                                "assets/images/galery.png"),
                                          )),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Gallery',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 40,
                          ),
                          Column(
                            children: <Widget>[
                              InkWell(
                                onTap: fromCamera,
                                child: Container(
                                  decoration:
                                      BoxDecoration(shape: BoxShape.circle),
                                  child: Material(
                                    elevation: 6,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(22.0)),
                                    child: Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                            image: AssetImage(
                                                "assets/images/camera.png"),
                                          )),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Camera',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
