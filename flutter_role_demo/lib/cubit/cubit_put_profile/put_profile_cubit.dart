import 'package:bloc/bloc.dart';
import 'package:flutter_role_demo/cubit/cubit_put_profile/put_profile_state.dart';
import 'package:flutter_role_demo/data/service/Put_profile_service.dart';


class PutProfileCubit extends Cubit<PutProfileState> {
  final PutProfileService service;

  PutProfileCubit({required this.service}) : super(const PutProfileState());

  Future<void> updateProfile({
    required int id,
    required String name,
    required String email,
    required String password,
  }) async {
    emit(state.copyWith(isLoading: true, error: ''));

    final result = await service.updateProfile(
      id: id,
      name: name,
      email: email,
      password: password,
    );

    result.fold(
      (errorMsg) => emit(state.copyWith(isLoading: false, error: errorMsg)),
      (data) => emit(state.copyWith(isLoading: false, data: data)),
    );
  }
}
