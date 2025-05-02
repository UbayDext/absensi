import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RolePage extends StatefulWidget {
  @override
  State<RolePage> createState() => _HomePageState();
}

class _HomePageState extends State<RolePage> {
  String _role = 'loading';
  String _konfirmasi = 'Guru sudah login';

  @override
  void initState() {
    super.initState();
    _getRole();
  }

  Future<void> _getRole() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _role = prefs.getString('role') ?? 'guest';
      _konfirmasi = prefs.getString('Selamat datang') ?? 'baik';
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_role == 'loading') return Center(child: CircularProgressIndicator());

    return Scaffold(
      appBar: AppBar(title: Text("Home")),
      body: Center(
        child: _role == 'admin'
            ? Text("Welcome, Admin! 🔧")
            : Text("Welcome, User! 👋"),
      ),
    );
  }
}
