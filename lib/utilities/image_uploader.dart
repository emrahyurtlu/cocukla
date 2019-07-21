import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:uuid/uuid.dart';

File file;
var assets = List<Asset>();
var links = List<String>();

Future<List<String>> uploadPickedImages() async {
  assets = await MultiImagePicker.pickImages(maxImages: 5, enableCamera: true);
  print(" ------------------------------------------------------------ ");
  print("Files are selected!");
  print(assets.length);
  print(" ------------------------------------------------------------ ");

  for (var asset in assets) {
    var result = _upload(asset);
    result.then((value) {
      links.add(value);
    });
  }

  return links;
}

Future<dynamic> _upload(Asset asset) async {
  ByteData byteData = await asset.requestOriginal();

  String extension = path.extension(asset.name);
  var fileName = Uuid().v1().toString() + extension;

  StorageReference ref = FirebaseStorage.instance.ref().child(fileName);

  StorageUploadTask task = ref.putData(byteData.buffer.asUint8List());

  StorageTaskSnapshot storageTaskSnapshot = await task.onComplete;
  
  return storageTaskSnapshot.ref.getDownloadURL();
}
