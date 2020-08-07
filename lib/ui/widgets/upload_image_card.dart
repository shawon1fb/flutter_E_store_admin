import 'dart:io';

import 'package:ecomadmin/core/utils/Image_picker_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_responsive_screen/flutter_responsive_screen.dart';
import 'package:shape_of_view/shape_of_view.dart';

class UploadImageCard extends StatefulWidget {
  final Function(File) onImageSelect;
  final Color borderColor;
  final File image;

  UploadImageCard({
    this.borderColor,
    this.image,
    @required this.onImageSelect,
  }) : assert(onImageSelect != null, "must pass a function onImageSelect");

  @override
  _UploadImageCardState createState() => _UploadImageCardState();
}

class _UploadImageCardState extends State<UploadImageCard> {
  File image;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    image = widget.image;
  }

  @override
  Widget build(BuildContext context) {
    final Function wp = Screen(MediaQuery.of(context).size).wp;
    final Function hp = Screen(MediaQuery.of(context).size).hp;
    return Container(
      child: ShapeOfView(
        shape: RoundRectShape(
          borderRadius: BorderRadius.circular(12),
          borderColor: widget.borderColor ?? Colors.white, //optional
          borderWidth: 2, //optional
        ),
        child: InkWell(
          onTap: () {
            FlutterImagePicker.imagePickerModalSheet(
              context: context,
              fromGallery: () async {
                image = await FlutterImagePicker.getImageGallery(context,
                    compress: true);
                if (image != null) {
                  widget.onImageSelect(image);
                }
             //   setState(() {});
              },
              fromCamera: () async {
                image = await FlutterImagePicker.getImageCamera(context,
                    compress: true);
                if (image != null) {
                  widget.onImageSelect(image);
                }
             //   setState(() {});
              },
            );
          },
          child: Container(
            height: wp(70),
            width: wp(70),
            decoration: BoxDecoration(
              color: Color(0xFF035AA6),
            ),
            child: widget.image != null
                ? Image.file(
                    widget.image,
                    fit: BoxFit.cover,
                  )
                : Container(
                    child: Center(
                      child: Icon(
                        Icons.camera_alt,
                        size: 50,
                        color: Colors.white,
                      ),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
