import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class FlutterFireBaseStorage {
  FirebaseStorage storage;

  static Future<String> uploadImage({
    File imageFile,
    String dirName,
  }) async {
    try {
      var fileName = imageFile.path.split("/").last;
      print(fileName);
      var path = "$dirName/$fileName";
      StorageReference ref = FirebaseStorage().ref().child(path);
      StorageUploadTask uploadTask = ref.putFile(imageFile);

      var dowUrl = await (await uploadTask.onComplete).ref.getDownloadURL();
      String url = dowUrl.toString();
      print(url);

      return url;
    } catch (e) {
      print("Image upload ERROR ;;;;------------------>>>>>>>");
      print(e);
    }
    return null;
  }
}
