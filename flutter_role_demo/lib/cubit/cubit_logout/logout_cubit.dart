import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_role_demo/cubit/cubit_logout/logout_state.dart';
import 'package:flutter_role_demo/data/service/logout_service.dart';

class LogoutCubit extends Cubit<LogoutState> {
  LogoutCubit() : super(LogoutInitial());

  Future<void> logout(String token) async {
    emit(state.copyWith(isLogout: true, error: '', isSucces: false));

    final result = await LogoutService().logout(token);

    result.fold(
      (errorMessage) {
        print("Error cek lagi");
        emit(state.copyWith(isLogout: false, error: errorMessage));
        print('State Emitted: ${state.toString()}');
      },
      (succesMessage) {
        print('EMITTING SUCCESS STATE');
        emit(state.copyWith(isLogout: false, isSucces: true));
        print('STATE EMITTED: ${state.toString()}');
      },
    );
  }
}
