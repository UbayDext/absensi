import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_role_demo/cubit/cubit_crud_kelas/crud_kelas_cubit.dart';
import 'package:flutter_role_demo/cubit/cubit_data_kelas_siswa/data_siswa_kelas_cubit.dart';
import 'package:flutter_role_demo/cubit/cubit_selected/selected_cubit.dart';
import 'package:flutter_role_demo/presentation/screen/crud_kelas_screen.dart';
import 'package:flutter_role_demo/presentation/screen/data_siswa_screen.dart';
import 'package:flutter_role_demo/presentation/screen/description_screen1.dart';
import 'package:flutter_role_demo/presentation/screen/description_screen2.dart';
import 'package:flutter_role_demo/presentation/screen/description_screen3.dart';
import 'package:flutter_role_demo/presentation/screen/register_screen.dart';
import 'package:flutter_role_demo/presentation/screen/role_screen.dart';
import 'package:flutter_role_demo/presentation/ui/main_ui.dart';
import 'package:flutter_role_demo/presentation/ui/split_ui.dart';
import 'package:flutter_role_demo/presentation/ui/split_ui2.dart';
import 'package:flutter_role_demo/role/role_page.dart';
import 'package:flutter_role_demo/presentation/screen/login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CrudKelasCubit>(
          create: (context) => CrudKelasCubit(),
        ),
        BlocProvider<DataSiswaKelasCubit>(
          create: (context) => DataSiswaKelasCubit(),
        ),
        BlocProvider(
          create: (context) => SelectedCubit(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => SplitUi(),
          '/ui': (context) => SplitUi2(),
          '/ue': (context) => DescriptionScreen1(),
          '/uii': (context) => DescriptionScreen2(),
          '/set': (context) => DescriptionScreen3(),
          '/role': (context) => RoleScreen(),
          '/home': (context) => LoginScreen(),
          '/register': (context) => RegisterScreen(),
          '/absensi': (context) => MainUi(),
          '/crudsiswa': (context) => CrudKelasScreen(),
         // Tambahkan route ini
        },
      ),
    );
  }
}


