import 'package:firebase_auth/firebase_auth.dart';

class LoginHelper {
  bool isLogin() {
    return FirebaseAuth.instance.currentUser() != null;
  }
}
