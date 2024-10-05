import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:parking/controllers/auth_controller.dart';
import 'package:parking/core/helpers/gap.dart';
import 'package:parking/core/helpers/validator.dart';
import 'package:parking/models/auth_model.dart';
import 'package:parking/views/home_screen.dart';
import 'package:parking/views/signup_screen.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    if (kDebugMode) {
      _emailController.text = 'a@b.cm';
      _passwordController.text = '12345678';
    }
  }

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
                      await context.read<AuthController>().loginUser(UserModel(
                          email: _emailController.text,
                          password: _passwordController.text));
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomeScreen(),
                          ));
                    }
                  },
                  child: const Text('Login')),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignUpScreen(),
                        ));
                  },
                  child: const Text('Create an Account'))
            ],
          ),
        ),
      ),
    );
  }
}
