import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:uuid/uuid.dart';

File file;
var assets = List<Asset>();

Future uploadImage() async {
  assets = await MultiImagePicker.pickImages(maxImages: 5, enableCamera: true);
  print(" ------------------------------------------------------------ ");
  print(assets);
  print(" ------------------------------------------------------------ ");

  for(var asset in assets){

  }
}

_upload(File file) async {
  String extension = path.extension(file.path);
  var newName = Uuid().v1().toString() + extension;
  FirebaseStorage.instance.ref().child(newName).putFile(file);
}

Future<dynamic> postImage(Asset imageFile) async {
  await imageFile.requestOriginal();
  String fileName = DateTime.now().millisecondsSinceEpoch.toString();
  StorageReference reference = FirebaseStorage.instance.ref().child(fileName);
  //StorageUploadTask uploadTask = reference.putData();
  //StorageUploadTask uploadTask = reference.putData(imageFile.imageData.buffer.asUint8List());
  //StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;
  //return storageTaskSnapshot.ref.getDownloadURL();
}
