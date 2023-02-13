import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tok_tok_app/manager/firebase_auth_client.dart';
import 'package:tok_tok_app/manager/firebase_storage_client.dart';
import 'package:tok_tok_app/manager/firestore_client.dart';

import 'app.dart';
import 'firebase_options.dart';

void main() async {
  await _setup();
  runApp(const App());
}

Future<void> _setup() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseUIAuth.configureProviders([
    EmailAuthProvider(),
    GoogleProvider(
        clientId:
            "995357910311-icm8nu3a9recpkdadgoghnkoi1e6sg98.apps.googleusercontent.com"),
  ]);

  Get.put(FirebaseAuthClient());
  Get.put(FirestoreClient());
  Get.put(FirebaseStorageClient());
}
