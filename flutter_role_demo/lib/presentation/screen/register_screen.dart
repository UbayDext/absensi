import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_role_demo/widget/warna.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _obsureText = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      print('Email: ${_emailController.text}');
      print('Password: ${_passwordController.text}');
    }
  }

  Future<void> login(
    BuildContext context,
    String username,
    String password,
  ) async {
    String role = username == 'admin' ? 'admin' : 'user';
    String konfirmasi = password == 'admin123' ? 'admin123' : '';

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('role', role);

    Navigator.pushReplacementNamed(context, '/crudsiswa');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Image.asset('assets/image/logo1.png', width: 194, height: 194),
                SizedBox(height: 10),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    hintText: 'Enter your Name...',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    hintText: 'Enter your Email...',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  validator: (V) {
                    if (V == null || V.isEmpty) return 'Email is required';
                    if (!V.contains('@')) return 'Invalid email format';
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _passwordController,
                  obscureText: _obsureText,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    hintText: 'Enter your Password',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obsureText ? Icons.visibility_off : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          _obsureText = !_obsureText;
                        });
                      },
                    ),
                  ),
                  validator: (v) {
                    if (v == null || v.isEmpty) return 'Password is required';
                    if (v.length < 6)
                      return 'Password must be at least 6 characters';
                  },
                ),
                SizedBox(height: 20,),
                TextFormField(
                  controller: _passwordController,
                  obscureText: _obsureText,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    hintText: 'Confirm your Password',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obsureText ? Icons.visibility_off : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          _obsureText = !_obsureText;
                        });
                      },
                    ),
                  ),
                  validator: (v) {
                    if (v == null || v.isEmpty) return 'Password is required';
                    if (v.length < 6)
                      return 'Password must be at least 6 characters';
                  },
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _submit,
                  child: const Text(
                    'Sign up',
                    style: TextStyle(color: Warna.mainColor, fontSize: 18.97),
                  ),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    backgroundColor: Warna.trueColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
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
    );
  }
}
