import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_role_demo/cubit/cubit_logout/logout_cubit.dart';
import 'package:flutter_role_demo/cubit/cubit_logout/logout_state.dart';
import 'package:flutter_role_demo/data/local_storange/local_storange.dart';
import 'package:flutter_role_demo/widget/warna.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool isDarkMode = false;

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
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage('assets/image/logo1.png'),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'Aisyah',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'aisyahaprilia123@gmail.com',
                      style: TextStyle(color: Colors.black54),
                    ),
                  ],
                ),
              ],
            ),
          ),

          Expanded(
            child: ListView(
              children: [
                ListTile(
                  leading: Image.asset(
                    'assets/image/edit_profile.png',
                    width: 24,
                  ),
                  title: const Text('Edit Profile'),
                  onTap: () {},
                ),
                ListTile(
                  leading: Image.asset(
                    'assets/image/Bacjup_dara.png',
                    width: 24,
                  ),
                  title: const Text('Backup Data'),
                  onTap: () {},
                ),
                ListTile(
                  leading: Image.asset('assets/image/Vector.png', width: 24),
                  title: const Text('Language'),
                  onTap: () {},
                ),
                ListTile(
                  leading: Image.asset('assets/image/share.png', width: 24),
                  title: const Text('Share'),
                  onTap: () {},
                ),

                const Divider(),

                SwitchListTile(
                  title: const Text('Dark mode'),
                  value: isDarkMode,
                  onChanged: (value) {
                    setState(() {
                      isDarkMode = value;
                    });
                  },
                ),

                const Divider(),

                BlocConsumer<LogoutCubit, LogoutState>(
                  listener: (context, state) {
                    if (state.isSucces) {
                      Navigator.pushReplacementNamed(context, '/home');
                    } else if (state.error.isNotEmpty) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(state.error)));
                    }
                  },
                  builder: (context, state) {
                    return ListTile(
                      leading: Icon(Icons.logout),
                      title: Text('Logout'),
                      onTap: () async {
                        final token = await LocalStorage().getToken();
                        print('TOKEN DITEMUKAN: $token');

                        if (token != null && token.isNotEmpty) {
                          context.read<LogoutCubit>().logout(token);
                        } else {
                          print('TOKEN KOSONG / NULL');
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Token tidak ditemukan'),
                            ),
                          );
                        }
                      },

                      trailing:
                          state.isLogout ? CircularProgressIndicator() : null,
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
