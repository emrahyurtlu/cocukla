import 'package:firebase_auth/firebase_auth.dart';

class CurrentUserHelper {
  Future<FirebaseUser> getCurrentUser() async {
    var current = await FirebaseAuth.instance.currentUser();
    return current;
  }
}
