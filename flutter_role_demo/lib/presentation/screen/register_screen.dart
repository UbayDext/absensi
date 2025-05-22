import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_role_demo/cubit/cubit_register/register_cubit.dart';
import 'package:flutter_role_demo/cubit/cubit_register/register_state.dart';
import 'package:flutter_role_demo/data/local_storange/local_storange.dart';
import 'package:flutter_role_demo/widget/warna.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: const _RegisterContent(),
    );
  }
}

class _RegisterContent extends StatefulWidget {
  const _RegisterContent();

  @override
  State<_RegisterContent> createState() => _RegisterContentState();
}

class _RegisterContentState extends State<_RegisterContent> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  bool _obscureText = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      context.read<RegisterCubit>().toRegister(
        _nameController.text.trim(),
        _emailController.text.trim(),
        _passwordController.text,
        _confirmController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state.ifError.isNotEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.ifError), backgroundColor: Colors.red),
          );
        }

        print('RESPONSE REGISTER: ${state.registerRespone}');

        final success = state.registerRespone.success ?? false;

        if (success) {
          LocalStorage().saveToken(state.registerRespone.data?.token?? ''); 
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Register berhasil"),
              backgroundColor: Warna.trueColor
            ),
          );
          Navigator.pushReplacementNamed(context, '/home'); 
        }
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Image.asset(
                    'assets/image/logo1.png',
                    width: 194,
                    height: 194,
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      hintText: 'Enter your Name...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      hintText: 'Enter your Email...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    validator: (v) {
                      if (v == null || v.isEmpty) return 'Email is required';
                      if (!v.contains('@')) return 'Invalid email format';
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      hintText: 'Enter your Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed:
                            () => setState(() => _obscureText = _obscureText),
                      ),
                    ),
                    validator: (v) {
                      if (v == null || v.isEmpty) return 'Password is required';
                      if (v.length < 6)
                        return 'Password must be at least 6 characters';
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _confirmController,
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      hintText: 'Re-enter your Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    validator: (v) {
                      if (v != _passwordController.text)
                        return 'Passwords do not match';
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  BlocBuilder<RegisterCubit, RegisterState>(
                    builder: (context, state) {
                      if (state.ifLoading)
                        return const CircularProgressIndicator();
                      return ElevatedButton(
                        onPressed: _submit,
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50),
                          backgroundColor: Warna.trueColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Text(
                          'Sign up',
                          style: TextStyle(
                            color: Warna.mainColor,
                            fontSize: 18.97,
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  RichText(
                    text: TextSpan(
                      text: 'Already have an account? ',
                      style: const TextStyle(color: Warna.TextColor),
                      children: [
                        TextSpan(
                          text: 'Log in here',
                          style: TextStyle(
                            color: Warna.trueColor,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer:
                              TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pushReplacementNamed(
                                    context,
                                    '/home',
                                  );
                                },
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
