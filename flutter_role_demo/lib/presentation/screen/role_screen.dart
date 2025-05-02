import 'package:flutter/material.dart';
import 'package:flutter_role_demo/widget/warna.dart';

class RoleScreen extends StatelessWidget {
  const RoleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Warna.trueColor,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Spacer(flex: 2),
                Image.asset('assets/image/logo1.png'),
                const SizedBox(height: 16),
                const Text(
                  'select your role to access the\naplication',
                  style: TextStyle(fontSize: 14),
                  textAlign: TextAlign.center,
                ),
                Spacer(flex: 1),
                SizedBox(
                  width: 250,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/home');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Warna.mainColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text(
                      'Teacher',
                      style: TextStyle(
                        fontSize: 18.97,
                        fontWeight: FontWeight.bold,
                        color: Warna.TextColor,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: 250,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/home');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Warna.mainColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text(
                      'Student',
                      style: TextStyle(
                        fontSize: 18.97,
                        fontWeight: FontWeight.bold,
                        color: Warna.TextColor,
                      ),
                    ),
                  ),
                ),
                Spacer(flex: 3),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
