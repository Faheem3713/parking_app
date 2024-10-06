import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:parking/core/helpers/error_helper.dart';
import 'package:parking/services/auth_services.dart';
import 'package:parking/models/auth_model.dart';

class AuthController extends ChangeNotifier {
  final AuthServices _authServices = AuthServices();

  UserModel userData = UserModel();

  void setLoading(bool value) {
    notifyListeners();
  }

  Future<void> registerUser(UserModel user) async {
    await ErrorHelper.handleError(() async {
      await _authServices.createUser(user);
      saveUser();
    });
  }

  Future<void> loginUser(UserModel user) async {
    await ErrorHelper.handleError(() async {
      await _authServices.login(user);
      await saveUser();
    });
  }

  Future<void> logOut() async {
    await ErrorHelper.handleError(() => _authServices.logOut());
  }

  Future<void> saveUser() async {
    final user = FirebaseAuth.instance.currentUser;
    userData = UserModel(email: user?.email, id: user?.uid);
  }
}
