import 'package:flutter/material.dart';
import 'package:flutter_role_demo/widget/warna.dart';

class DescriptionScreen2 extends StatelessWidget {
   DescriptionScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Warna.mainColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  const Text(
                    'Sekolahin',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2C2C2C),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Easy way to record student\nattendance at school',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 24),
                
                  Image.asset(
                    'assets/image/logo3.png',// ini error ketika nama file di ubah
                    height: 250,
                  ),
                  const SizedBox(height: 24),
                 
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 8,
                        width: 24,
                        decoration: BoxDecoration(
                          color: Warna.waitColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        height: 8,
                        width: 24,
                        decoration: BoxDecoration(
                          color: Warna.midColor,
                         borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        height: 8,
                        width: 8,
                        decoration: BoxDecoration(
                          color: Warna.waitColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                children: [
                  const Text(
                    'data collection easier',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Easy way for teachers to collect data student",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black54),
                  ),
                  const SizedBox(height: 24),
                 
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        backgroundColor: const Color(0xFF28C76F), // hijau
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/set');
                      },
                      child: const Text(
                        'Next',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}