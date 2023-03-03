import 'package:chat/core/services/auth/auth_service.dart';
import 'package:flutter/material.dart';

import '../components/auth_form.dart';
import '../core/models/auth_form_data.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool _isLoading = false;

  Future<void> _handleSubmit(AuthFormData formData) async {
    if (!mounted) return;
    try {
      setState(() => _isLoading = true);
      if (formData.isLogin) {
        await AuthService().login(formData.email, formData.password);
      } else {
        await AuthService().signUp(
          formData.name,
          formData.email,
          formData.password,
          formData.image,
        );
      }
    } catch (e) {
      print(e);
    } finally {
      if (!mounted) return;
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xffc7aaf3),
                  Color(0xff9259c5),
                  Color(0xff8f55ff),
                  Color(0xff7615ff),
                ],
              ),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              child: AuthForm(onSubmit: _handleSubmit),
            ),
          ),
          if (_isLoading)
            Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                ),
                child: const Center(
                  child: CircularProgressIndicator(
                    color: Colors.indigo,
                  ),
                )),
        ],
      ),
    );
  }
}
