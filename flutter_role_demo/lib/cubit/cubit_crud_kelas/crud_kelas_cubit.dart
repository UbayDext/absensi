  import 'package:bloc/bloc.dart';
  import 'package:flutter_role_demo/cubit/cubit_crud_kelas/crud_kelas_state.dart';

  class CrudKelasCubit extends Cubit<CrudKelasState> {
    CrudKelasCubit() : super(CrudKelasState());

    void addKelas(String kelas) {
      final newClass = List<String>.from(state.kelas)..add(kelas);
      emit(state.copyWith(kelas: newClass));
    }

    void deleteKelas(int index) {
      emit(state.copyWith(kelas: List.from(state.kelas)..removeAt(index)));
    }

    void editKelas(int index, String kelasBaru) {
      final newList = List<String>.from(state.kelas);
      newList[index] = kelasBaru;
      emit(state.copyWith(kelas: newList));
    }
  }
