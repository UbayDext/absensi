import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_role_demo/widget/warna.dart';

class SplitUi extends StatefulWidget {
   SplitUi({super.key});

  @override
  State<SplitUi> createState() => _SplitUiState();
}

class _SplitUiState extends State<SplitUi> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, '/ui');
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Warna.trueColor,
    );
  }
}