import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'dart:io';

class Storage {
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  Future<void> uploadFiles(String filePath, String fileName) async {
    File file = File(filePath);

    try {
      await storage.ref('testfolder/$fileName').putFile(file);
    } on firebase_core.FirebaseException catch (e) {
      print(e);
    }
  }

  Future<firebase_storage.ListResult> listFiles() async {
    firebase_storage.ListResult results =
        await storage.ref('testfolder').listAll();
    results.items.forEach((firebase_storage.Reference ref) {
      print("Found File: $ref");
    });
    return results;
  }

  Future<String> downloadURL(String imgName) async {
    String downloadUrl =
        await storage.ref('testfolder/$imgName').getDownloadURL();
    return downloadUrl;
  }
}
