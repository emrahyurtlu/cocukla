
import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
//import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:uuid/uuid.dart';
/*
File file;
var assets = List<Asset>();
var links = List<String>();

Future<List<Asset>> pickImages({int maxImages = 5}) async {
  assets = await MultiImagePicker.pickImages(
    maxImages: maxImages,
  );
  print(" ------------------------------------------------------------ ");
  print("Files are selected!");
  print(assets.length);
  print(" ------------------------------------------------------------ ");

  return assets;
}

Future<List<String>> uploadPickedImages() async {
  assets = await MultiImagePicker.pickImages(maxImages: 5);
  print(" ------------------------------------------------------------ ");
  print("Files are selected!");
  print(assets.length);
  print(" ------------------------------------------------------------ ");

  for (var asset in assets) {
    var result = uploadSelectedAsset(asset);
    result.then((value) {
      links.add(value);
    });
  }

  return links;
}

Future<List<String>> uploadSelectedAssets(List<Asset> assets,
    [String folderName = ""]) async {
  print(" ------------------------------------------------------------ ");
  print("Files are selected!");
  print(assets.length);
  print(" ------------------------------------------------------------ ");

  links.clear();

  for (var asset in assets) {
    var result = await uploadSelectedAsset(asset, folderName);
    if (result != null) {
      print("UPLOADED PHOTO LINK: " + result);
      links.add(result);
    }
  }

  return links;
}

Future<dynamic> uploadSelectedAsset(Asset asset,
    [String folderName = ""]) async {
  ByteData byteData = await asset.requestOriginal();

  String extension = path.extension(asset.name);
  var fileName = Uuid().v1().toString() + extension;

  StorageReference ref = FirebaseStorage.instance
      .ref()
      .child(folderName != "" ? folderName + "/" + fileName : fileName);

  StorageUploadTask task = ref.putData(byteData.buffer.asUint8List());

  StorageTaskSnapshot storageTaskSnapshot = await task.onComplete;

  var downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();

  return downloadUrl;
}
*/
