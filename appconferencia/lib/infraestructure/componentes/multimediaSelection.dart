// ignore_for_file: file_names, camel_case_types

import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class multimediaSelection {
  Future<PlatformFile?> selectFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return null;
    return result.files.first;
  }

  Future<String> uploadFile(PlatformFile archivo, String carpeta) async {
    final path = '$carpeta/${archivo.name}';
    final file = File(archivo.path!);

    UploadTask uploadTask;

    final ref = FirebaseStorage.instance.ref().child(path);
    uploadTask = ref.putFile(file);

    final snapshot = await uploadTask.whenComplete(() {});

    final urlDownload = await snapshot.ref.getDownloadURL();

    return urlDownload;
  }
}
