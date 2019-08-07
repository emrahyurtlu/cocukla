import 'dart:async';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:uuid/uuid.dart';

Future<File> getImage({ImageSource source = ImageSource.gallery}) async {
  var image = await ImagePicker.pickImage(source: source);
  //assert(image != null, "Image could not picked");
  return image;
}

Future<String> uploadFile(File file, [String folderName = ""]) async {

  var byteData = await file.readAsBytes();

  String extension = path.extension(file.path);
  var fileName = Uuid().v1().toString() + extension;
  fileName = folderName != "" ? folderName + "/" + fileName : fileName;

  StorageReference ref = FirebaseStorage.instance.ref().child(fileName);

  StorageUploadTask task = ref.putData(byteData);

  StorageTaskSnapshot storageTaskSnapshot = await task.onComplete;

  var downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();

  return downloadUrl;
}
