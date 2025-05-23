import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_role_demo/cubit/cubit_get_profile/get_profile_state.dart';
import 'package:flutter_role_demo/data/local_storange/local_storange.dart';


class GetProfileCubit extends Cubit<GetProfileState> {
  GetProfileCubit() : super(const GetProfileState());

  Future<void> loadUserFromLocal() async {
    emit(GetProfileState(isLoading: true));

    try {
      final user = LocalStorage().getUser();

      if (user == null) {
        emit(GetProfileState(isError: 'User tidak ditemukan di local storage'));
        return;
      }

      emit(GetProfileState(user: user, isLoading: false));
    } catch (e) {
      emit(GetProfileState(isError: e.toString()));
    }
  }
}
