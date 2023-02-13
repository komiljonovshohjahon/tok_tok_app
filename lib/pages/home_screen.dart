import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tok_tok_app/manager/firebase_storage_client.dart';
import 'home_screen_controller.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => HomeController());
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (controller.image.value != "")
            Image.network(
              controller.image.value,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                );
              },
            ),
          ElevatedButton(
            onPressed: () {
              controller.getImage();
            },
            child: const Text('Get Image'),
          ),
          ElevatedButton(
            onPressed: () {
              controller.uploadImage();
            },
            child: const Text('Upload Image'),
          ),
        ],
      ),
    );
  }
}
