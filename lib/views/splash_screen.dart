import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:parking/controllers/auth_controller.dart';
import 'package:parking/core/helpers/routing_helper.dart';
import 'package:parking/views/home_screen.dart';
import 'package:parking/views/login_screen.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    checkLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator.adaptive(),
      ),
    );
  }

  void checkLogin() async {
    final user = FirebaseAuth.instance.currentUser?.uid;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (user == null) {
        context.pushAndRemoveUntil(const LoginScreen());
      } else {
        context.read<AuthController>().saveUser();
        context.pushAndRemoveUntil(const HomeScreen());
      }
    });
  }
}
