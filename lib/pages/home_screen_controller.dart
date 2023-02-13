import 'package:get/get.dart';

import '../manager/firebase_storage_client.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.find();
  final RxString image = "".obs;

  void getImage() async {
    FirebaseStorageClient storage = FirebaseStorageClient();
    final String image = await storage.getImage();
    this.image.value = image;
  }

  void uploadImage() async {
    FirebaseStorageClient storage = FirebaseStorageClient();
    await storage.uploadImage();
  }
}
