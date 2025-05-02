import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_role_demo/cubit/cubit_selected/selected_cubit.dart';
import 'package:flutter_role_demo/cubit/cubit_selected/selected_state.dart';
import 'package:flutter_role_demo/widget/warna.dart';

class DescriptionScreen3 extends StatelessWidget {
  DescriptionScreen3({super.key});

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
                    style: TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                  const SizedBox(height: 24),

                  Image.asset(
                    'assets/image/logo4.png', // ini error ketika nama file di ubah
                    height: 250,
                  ),
                  const SizedBox(height: 24),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 8,
                        width: 8,
                        decoration: BoxDecoration(
                          color: Warna.waitColor,
                          shape: BoxShape.circle,
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
                      const SizedBox(width: 8),
                      Container(
                        height: 8,
                        width: 24,
                        decoration: BoxDecoration(
                          color: Warna.midColor,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                children: [
                  const Text(
                    'start your application',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "easy way for teachers and parents to monitor children",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black54),
                  ),
                  const SizedBox(height: 24),

                  BlocBuilder<SelectedCubit, SelectedState>(
                    builder: (context, state) {
                      return SizedBox(
                        width: double.infinity,
                        child: Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  context.read<SelectedCubit>().toogleStatus(
                                    'login',
                                  );
                                  Navigator.pushReplacementNamed(context, '/role');
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      (state.selectedButton['login'] == true)
                                          ? Warna.trueColor
                                          : Warna.mainColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  padding: EdgeInsets.symmetric(vertical: 14),
                                ),
                                child: Text(
                                  'Log in',
                                  style: TextStyle(
                                    color:
                                        (state.selectedButton['login'] == true)
                                            ? Warna.mainColor
                                            : Warna.TextColor,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  context.read<SelectedCubit>().toogleStatus(
                                    'signup',
                                  );
                                  Navigator.pushReplacementNamed(context, '/register');
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      (state.selectedButton['signup'] == true)
                                          ? Warna.trueColor
                                          : Warna.mainColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  padding: EdgeInsets.symmetric(vertical: 14),
                                ),
                                child: Text(
                                  'Sign up',
                                  style: TextStyle(
                                    color:
                                        (state.selectedButton['signup'] == true)
                                            ? Warna.mainColor
                                            : Warna.TextColor,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
