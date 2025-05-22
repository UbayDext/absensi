import 'package:bloc/bloc.dart';
import 'package:flutter_role_demo/cubit/cubit_login/login_state.dart';
import 'package:flutter_role_demo/data/local_storange/local_storange.dart';
import 'package:flutter_role_demo/data/service/login_service.dart';


class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginState());

  Future<void> toLogin(String email, String password) async {
    emit(state.copyWith(isLoading: true));

    var result = await LoginService().login(email: email, password: password);

    result.fold(
      (left) => emit(state.copyWith(error: left)),
      (right) {
        // Simpan ke state
        emit(state.copyWith(loginResponse: right));

        // ✅ Simpan token
        final token = right.data?.accessToken;
        if (token != null && token.isNotEmpty) {
          LocalStorage().saveToken(token);
          print('✅ TOKEN DISIMPAN: $token');
        } else {
          print('❌ TOKEN NULL / KOSONG');
        }

        // ✅ Simpan user
        final user = right.data?.user;
        if (user != null) {
          LocalStorage().saveUser(user);
          print('✅ USER DISIMPAN: ${user.name}');
        } else {
          print('❌ USER NULL');
        }
      },
    );

    emit(state.copyWith(isLoading: false));
  }
}
