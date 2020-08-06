import 'dart:io';
import 'dart:typed_data';

import 'package:ecomadmin/core/utils/Image_picker_methods.dart';
import 'package:ecomadmin/core/utils/log.dart';
import 'package:ecomadmin/ui/widgets/rounded_button.dart';
import 'package:filesize/filesize.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:flutter_responsive_screen/flutter_responsive_screen.dart';
import 'package:image_size_getter/image_size_getter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as I;

class NewProDuctUpload extends StatefulWidget {
  @override
  _NewProDuctUploadState createState() => _NewProDuctUploadState();
}

class _NewProDuctUploadState extends State<NewProDuctUpload> {
  File image;
  File image2;

  Future<File> testCompressAndGetFile(File file) async {
    Directory tempDir = await getTemporaryDirectory();
    String targetPath = tempDir.path;
    L.log(
      file.absolute.path,
    );
    var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      targetPath,
      quality: 88,
      rotate: 180,
    );

    print(file.lengthSync());
    print(result.lengthSync());

    return result;
  }

  @override
  Widget build(BuildContext context) {
    final Function wp = Screen(MediaQuery.of(context).size).wp;
    final Function hp = Screen(MediaQuery.of(context).size).hp;

    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Container(
                child: RoundBoarderButton(
                  text: "Image",
                  onPress: () {
                    FlutterImagePicker.imagePickerModalSheet(
                      context: context,
                      fromCamera: () async {
                        image2 = await FlutterImagePicker.getImageCamera(
                            context,
                            compress: false);
                        image = await FlutterImagePicker.compressImage(image2);
                        setState(() {});
                      },
                      fromGallery: () async {
                        image2 = await FlutterImagePicker.getImageGallery(
                            context,
                            compress: false);
                        image = image =
                            await FlutterImagePicker.compressImage(image2);

                        setState(() {});
                      },
                    );
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              AspectRatio(
                aspectRatio: 4 / 3,
                child: image != null ? Image.file(image) : Container(),
              ),
              SizedBox(
                height: 20,
              ),
              Text('${image2 != null ? ImageSizGetter.getSize(image2) : 0}'),
              Text(
                  'Original size : ${image2 != null ? image2.lengthSync() : 0}'),
              Text(
                  'Compress Size ${image != null ? filesize(image.lengthSync(), 4) : 0} '),
              Text(
                  'Original size ${image2 != null ? filesize(image2.lengthSync(), 4) : 0}'),
            ],
          ),
        ),
      ),
    );
  }
}
