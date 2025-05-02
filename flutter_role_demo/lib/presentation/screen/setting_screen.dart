import 'package:flutter/material.dart';
import 'package:flutter_role_demo/widget/warna.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Warna.BgColor,
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
            height: 160,
            decoration: const BoxDecoration(color: Warna.trueColor),
            child: Align(
              alignment: Alignment.center,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: AssetImage('assets/image/logo1.png'),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('username', style: TextStyle(fontSize: 19.48)),
                        Text('profile'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: Container(
              color: Warna.mainColor,
              child: ListView(
                children: [
                  ListTile(
                    leading: Icon(Icons.edit),
                    title: Text('edit profile'),
                    onTap: () {
                      Navigator.pushNamed(context, '/crudsiswa');
                    },
                  ),
                 IconButton(onPressed: (){}, icon: Icon(Icons.edit))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
