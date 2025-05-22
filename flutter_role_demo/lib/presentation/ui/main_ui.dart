import 'package:flutter/material.dart';
import 'package:flutter_role_demo/presentation/screen/attendence_screen.dart';
import 'package:flutter_role_demo/presentation/screen/home_screen.dart';
import 'package:flutter_role_demo/presentation/screen/lesson_screen.dart';
import 'package:flutter_role_demo/presentation/screen/setting_screen.dart';
import 'package:flutter_role_demo/widget/warna.dart';

class MainUi extends StatefulWidget {
  const MainUi({super.key});

  @override
  State<MainUi> createState() => _MainUiState();
}

class _MainUiState extends State<MainUi> {
  int conditionsState = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          conditionsState != 3
              ? AppBar(
                backgroundColor: Warna.trueColor,
                title: Image.asset('assets/image/logo_appbar.png'),
              )
              : null,
      body: listofContect[conditionsState],
      backgroundColor: Warna.trueColor,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Warna.trueColor,
        currentIndex: conditionsState,
        onTap: (index) {
          setState(() {
            conditionsState = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: false,
        showSelectedLabels: true,
        selectedItemColor: Warna.midColor,
        unselectedItemColor: Warna.TextColor,
        items: [
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage('assets/image/home_black.png'),
              color: conditionsState == 0 ? Warna.midColor : Warna.TextColor,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage('assets/image/attendence_black.png'),
              color: conditionsState == 1 ? Warna.midColor : Warna.TextColor,
            ),
            label: 'Attendence',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage('assets/image/clock_black.png'),
              color: conditionsState == 2 ? Warna.midColor : Warna.TextColor,
            ),
            label: 'Recent',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage('assets/image/setting_black.png'),
              color: conditionsState == 3 ? Warna.midColor : Warna.TextColor,
            ),
            label: 'Settings',
          ),
        ],
      ),
    );
  }

  List listofContect = [
    HomeScreen(),
    AttendenceScreen(),
    LessonScreen(),
    SettingScreen(),
  ];
}
