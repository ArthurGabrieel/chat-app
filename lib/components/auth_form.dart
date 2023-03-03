import 'dart:io';

import 'package:chat/components/user_image_picker.dart';
import 'package:flutter/material.dart';

import '../core/models/auth_form_data.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({
    Key? key,
    required this.onSubmit,
  }) : super(key: key);

  final void Function(AuthFormData) onSubmit;

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  final _formData = AuthFormData();

  void _handleImagePick(File image) {
    _formData.image = image;
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: Theme.of(context).errorColor,
      ),
    );
  }

  void _submit() {
    if (_formData.image == null && !_formData.isLogin) {
      return _showError('Please pick an image');
    }

    if (_formKey.currentState?.validate() ?? false) {
      widget.onSubmit(_formData);
      _formKey.currentState!.save();
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.linear,
      height: _formData.isLogin ? 350 : 570,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.all(20),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  if (!_formData.isLogin)
                    UserImagePicker(onImagePick: _handleImagePick),
                  if (!_formData.isLogin)
                    TextFormField(
                      key: const ValueKey('name'),
                      initialValue: _formData.name,
                      keyboardType: TextInputType.name,
                      decoration: const InputDecoration(
                        labelText: 'Name',
                      ),
                      onChanged: (value) => _formData.name = value,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a name';
                        }
                        if (value.length < 4) {
                          return 'Name must be at least 4 characters long';
                        }
                        return null;
                      },
                    ),
                  TextFormField(
                    key: const ValueKey('email'),
                    initialValue: _formData.email,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                    ),
                    onChanged: (value) => _formData.email = value,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter an email';
                      }
                      if (!value.contains('@')) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    key: const ValueKey('password'),
                    obscureText: true,
                    initialValue: _formData.password,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                    ),
                    onChanged: (value) => _formData.password = value,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters long';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  ElevatedButton(
                    onPressed: _submit,
                    child: Text(_formData.isLogin ? 'Login' : 'Signup'),
                  ),
                  TextButton(
                    child: Text(_formData.isLogin
                        ? 'Create new account'
                        : 'I already have an account'),
                    onPressed: () {
                      setState(() => _formData.toggleMode());
                    },
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
