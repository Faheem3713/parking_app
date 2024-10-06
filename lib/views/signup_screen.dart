import 'package:flutter/material.dart';
import 'package:parking/controllers/auth_controller.dart';
import 'package:parking/core/helpers/routing_helper.dart';
import 'package:parking/core/widgets/alert_dialog.dart';
import 'package:parking/core/widgets/gap.dart';
import 'package:parking/core/helpers/validator.dart';
import 'package:parking/models/auth_model.dart';
import 'package:parking/views/home_screen.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                validator: FormValidator().validateEmail,
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
              ),
              const VGap(15),
              TextFormField(
                validator: FormValidator().validatePassword,
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
              ),
              const VGap(15),
              ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState?.validate() ?? false) {
                      await context.read<AuthController>().registerUser(
                          UserModel(
                              email: _emailController.text,
                              password: _passwordController.text));
                      await cAlertDialog(
                          context: context,
                          message: 'Account Successfully Created');
                      context.pushAndRemoveUntil(const HomeScreen());
                    }
                  },
                  child: const Text('Sign Up'))
            ],
          ),
        ),
      ),
    );
  }
}
