import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_role_demo/Model/register/register.dart';
import 'package:flutter_role_demo/cubit/cubit_register/register_state.dart';


import 'package:flutter_role_demo/data/service/register_service.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterState());

  Future<void> toRegister(
    String name,
    String email,
    String password,
    String confirmPassword,
  ) async {
    emit(
      state.copyWith(ifLoading: true),
    );

    final watch = await RegisterService().register(
      name: name,
      email: email,
      password: password,
      passwordConfirmation: confirmPassword,
    );

    watch.fold(
      (left) {
        emit(state.copyWith(ifError: left, ifLoading: false));
      },

      (right) {
        print('RESPONSE REGISTER: ${right.toJson()}');
        emit(state.copyWith(registerRespone: right, ifLoading: false));
      },
    );
  }
}
