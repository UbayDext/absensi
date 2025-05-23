import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_role_demo/cubit/cubit_logout/logout_cubit.dart';
import 'package:flutter_role_demo/cubit/cubit_logout/logout_state.dart';
import 'package:flutter_role_demo/data/local_storange/local_storange.dart';
import 'package:flutter_role_demo/Model/login/user.dart';
import 'package:flutter_role_demo/widget/warna.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool isDarkMode = false;
  User? user;

  @override
  void initState() {
    super.initState();
    getUserInfo();
  }

  void getUserInfo() {
    final storedUser = LocalStorage().getUser();
    if (storedUser != null) {
      setState(() {
        user = storedUser;
      });
    }
  }

  String _getInitial(String name) {
    if (name.trim().isEmpty) return '?';
    List<String> parts = name.trim().split(' ');
    if (parts.length == 1) {
      return parts[0][0].toUpperCase();
    } else {
      return (parts[0][0] + parts[1][0]).toUpperCase();
    }
  }

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
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.white,
                  child: Text(
                    _getInitial(user?.name ?? ''),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      user?.name ?? 'Loading...',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      user?.email ?? '',
                      style: const TextStyle(color: Colors.black54),
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
                  onTap: () {
                    Navigator.pushNamed(context, '/profile');
                  },
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
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(state.error)));
                    }
                  },
                  builder: (context, state) {
                    return ListTile(
                      leading: const Icon(Icons.logout),
                      title: const Text('Logout'),
                      onTap: () async {
                        final token = await LocalStorage().getToken();
                        if (token != null && token.isNotEmpty) {
                          context.read<LogoutCubit>().logout(token);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Token tidak ditemukan'),
                            ),
                          );
                        }
                      },
                      trailing:
                          state.isLogout ? const CircularProgressIndicator() : null,
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
