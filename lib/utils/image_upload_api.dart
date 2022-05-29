import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

firebase_storage.FirebaseStorage storage =
    firebase_storage.FirebaseStorage.instance;

Future<dynamic> uploadImage({
  required File file,
  required bool isImage,
}) async {
  File _file = File(file.path.toString());

  firebase_storage.UploadTask task = firebase_storage.FirebaseStorage.instance
      .ref(isImage
          ? 'images/${DateTime.now().toUtc()}'
          : 'videos/${DateTime.now().toUtc()}')
      .putFile(_file);

  try {
    await task;
    var urlFile = await _downloadURLS(filePath: task.snapshot.ref.fullPath);
    return urlFile;
  } catch (e) {
    print('error on upload: $e');
    return false;
  }
}

Future<dynamic> _downloadURLS({String? filePath}) async {
  String downloadURL = await firebase_storage.FirebaseStorage.instance
      .ref(filePath)
      .getDownloadURL();

  return downloadURL;
}
