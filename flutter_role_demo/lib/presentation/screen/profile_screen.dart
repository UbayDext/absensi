import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_role_demo/widget/warna.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Warna.BgColor,
      body: Column(
        children: [
          Container(
            width: double.infinity
          )
        ],
      ),
    );
  }
}