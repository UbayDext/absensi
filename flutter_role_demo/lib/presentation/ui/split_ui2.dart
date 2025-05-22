import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_role_demo/widget/warna.dart';


class SplitUi2 extends StatefulWidget {
  SplitUi2({super.key});

  @override
  State<SplitUi2> createState() => _SplitUi2State();
}

class _SplitUi2State extends State<SplitUi2> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/ue');
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Warna.trueColor,
      body: Center(
        child: 
          Image.asset('assets/image/logo1.png',),
        
      ),
    );
  }
}
