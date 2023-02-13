import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'package:tok_tok_app/manager/picker_client.dart';

class FirebaseStorageClient {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> getImage() async {
    final storageRef = _storage.ref();
    final String a1 = await storageRef
        .child("extended_image_cropped_image.jpg")
        .getDownloadURL();
    return a1;
  }

  Future<void> uploadImage() async {
    final PickerClient picker = PickerClient();
    final PlatformFile? file = await picker.pickImage();
    if (file == null) return;
    final storageRef = _storage.ref().child('/images/${file.name}');
    final Uint8List? bytes = file.bytes;
    final UploadTask uploadTask = storageRef.putData(bytes!);
    if (bytes == null) return;
    Get.showOverlay(
        asyncFunction: () async {
          await uploadTask.snapshotEvents.listen((event) {
            print(event.bytesTransferred);
            print(event.totalBytes);
          });
        },
        loadingWidget: Center(
            child:
                ElevatedButton(onPressed: () {}, child: const Text("Cancel"))));
  }
}
