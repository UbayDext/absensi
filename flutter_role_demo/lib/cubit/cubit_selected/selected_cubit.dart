import 'package:bloc/bloc.dart';
import 'package:flutter_role_demo/cubit/cubit_selected/selected_state.dart';

class SelectedCubit extends Cubit<SelectedState> {
  SelectedCubit() : super(const SelectedState());

  void toogleStatus(String selected) {
    final newSelectedButton = {'login': false, 'signup': false};
    newSelectedButton[selected] = true;

    emit(state.copyWith(selectedButton: newSelectedButton));
  }
}
