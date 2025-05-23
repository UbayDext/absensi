import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_role_demo/cubit/cubit_Get_mapel/get_mapel_cubit.dart';
import 'package:flutter_role_demo/cubit/cubit_Post_mapel/post_mapel_cubit.dart';
import 'package:flutter_role_demo/cubit/cubit_crud_kelas/crud_kelas_cubit.dart';
import 'package:flutter_role_demo/cubit/cubit_data_kelas_siswa/data_siswa_kelas_cubit.dart';
import 'package:flutter_role_demo/cubit/cubit_deleted_class/deleted_class_cubit.dart';
import 'package:flutter_role_demo/cubit/cubit_deleted_mapela/deleted_mapela_cubit.dart';
import 'package:flutter_role_demo/cubit/cubit_get_kelas/get_data_kelas_cubit.dart';
import 'package:flutter_role_demo/cubit/cubit_get_studen/get_studen_cubit.dart';
import 'package:flutter_role_demo/cubit/cubit_logout/logout_cubit.dart';
import 'package:flutter_role_demo/cubit/cubit_post_studensStatus/post_studens_status_cubit.dart';
import 'package:flutter_role_demo/cubit/cubit_put_mapel/put_mapel_cubit.dart';
import 'package:flutter_role_demo/cubit/cubit_put_profile/put_profile_cubit.dart';
import 'package:flutter_role_demo/cubit/cubit_put_status/put_status_cubit.dart';
import 'package:flutter_role_demo/cubit/cubit_register/register_cubit.dart';
import 'package:flutter_role_demo/cubit/cubit_selected/selected_cubit.dart';
import 'package:flutter_role_demo/cubit/cubit_update_class/update_class_cubit.dart';
import 'package:flutter_role_demo/data/local_storange/local_storange.dart';
import 'package:flutter_role_demo/data/service/Get_mapel_service.dart';
import 'package:flutter_role_demo/data/service/Get_student_service.dart';
import 'package:flutter_role_demo/data/service/Post_student_service.dart';
import 'package:flutter_role_demo/data/service/Put_mapel_service.dart';
import 'package:flutter_role_demo/data/service/Put_profile_service.dart';
import 'package:flutter_role_demo/data/service/get_kelas_service.dart';
import 'package:flutter_role_demo/data/service/put_student_service.dart';
import 'package:flutter_role_demo/presentation/screen/attendence_screen.dart';
import 'package:flutter_role_demo/presentation/screen/attendence_siswa_screen.dart';

import 'package:flutter_role_demo/presentation/screen/description_screen1.dart';
import 'package:flutter_role_demo/presentation/screen/description_screen2.dart';
import 'package:flutter_role_demo/presentation/screen/description_screen3.dart';
import 'package:flutter_role_demo/presentation/screen/profile_screen.dart';
import 'package:flutter_role_demo/presentation/screen/register_screen.dart';
import 'package:flutter_role_demo/presentation/screen/role_screen.dart';
import 'package:flutter_role_demo/presentation/ui/main_ui.dart';
import 'package:flutter_role_demo/presentation/ui/split_ui.dart';
import 'package:flutter_role_demo/presentation/ui/split_ui2.dart';

import 'package:flutter_role_demo/presentation/screen/login_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorage().init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CrudKelasCubit>(create: (context) => CrudKelasCubit()),
        BlocProvider(create: (context) => SelectedCubit()),

        BlocProvider<LogoutCubit>(create: (context) => LogoutCubit()),

        BlocProvider<RegisterCubit>(create: (context) => RegisterCubit()),
        BlocProvider(
          create:
              (_) =>
                  GetDataKelasCubit(classroomService: GetKelasService())
                    ..getAllKelas(),
        ),

        BlocProvider(create: (_) => UpdateClassCubit()),

        BlocProvider(create: (_) => DeleteClassCubit()),

        BlocProvider(create: (_) => DataSiswaKelasCubit()),
        BlocProvider(create: (_) => PostMapelCubit()),
        BlocProvider(
          create:
              (_) =>
                  GetMapelCubit(getMapelService: GetMapelService())
                    ..getAllMapel(),
        ),
        BlocProvider(create: (_) => PutMapelCubit(PutMapelService())),
        BlocProvider(create: (_) => DeletedMapelaCubit()),
        BlocProvider(
          create:
              (_) =>
                  GetStudenCubit(getStudentService: GetStudentService())
                    ..getAllStudent(),
        ),
        BlocProvider(create: (_) => PostStudensStatusCubit(service: PostStudentService())),
        BlocProvider(create: (_) => PutStudensStatusCubit(service: PutStudentService())),
        BlocProvider(create: (_) => PutProfileCubit(service: PutProfileService())),
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
          '/dataKelas': (context) => AttendenceScreen(),
          '/absenkelas':
              (context) =>
                  AttendenceSiswaScreen(namaKelas: '', tanggal: DateTime.now()),
          '/profile': (context) => ProfileScreen(),
        },
      ),
    );
  }
}
