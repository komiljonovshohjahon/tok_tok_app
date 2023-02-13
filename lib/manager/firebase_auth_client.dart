import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthClient {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool get isSignedIn => _auth.currentUser != null;
}
