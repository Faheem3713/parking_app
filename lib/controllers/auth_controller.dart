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
    await ErrorHelper.handleError(_authServices.createUser(user));
  }

  Future<void> loginUser(UserModel user) async {
    await ErrorHelper.handleError(_authServices.login(user));
  }

  Future<void> logOut() async {
    await ErrorHelper.handleError(_authServices.logOut());
  }

  void saveUser(User user) {
    userData = UserModel(email: user.email, id: user.uid);
  }
}
