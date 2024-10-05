import 'package:firebase_auth/firebase_auth.dart';
import 'package:parking/models/auth_model.dart';

class AuthServices {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<void> createUser(UserModel user) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
      email: user.email!,
      password: user.password!,
    );
  }

  Future<void> login(UserModel user) async {
    await _firebaseAuth.signInWithEmailAndPassword(
      email: user.email!,
      password: user.password!,
    );
  }

  Future<void> logOut() async {
    await _firebaseAuth.signOut();
  }
}
