import 'package:bloc/bloc.dart';
import 'package:flutter_role_demo/cubit/cubit_data_kelas_siswa/data_siswa_kelas_state.dart';

class DataSiswaKelasCubit extends Cubit<DataSiswaKelasState> {
  DataSiswaKelasCubit() : super(DataSiswaKelasState());

  // Di dalam DataSiswaKelasCubit
void tambahSiswa(String namaSiswa) {
  final newSiswa = List<String>.from(state.siswa)..add(namaSiswa);
  final newStatusSiswa = Map<String, bool?>.from(state.statusSiswa)
    ..[namaSiswa] = null;

  emit(state.copyWith(
    siswa: newSiswa,
    statusSiswa: newStatusSiswa,
  ));
}

  void deleteSiswa(int index){
    emit(state.copyWith(siswa: List.from(state.siswa)..removeAt(index),
    ),
    );
  }

  void editSiswa(int index, String siswaBaru){
    final newSiswa = List<String>.from(state.siswa);
    newSiswa[index] = siswaBaru;
    emit(state.copyWith(siswa: newSiswa));
  }

   void toggleStatus(String namaSiswa) {
    final current = (state.statusSiswa)[namaSiswa];
    bool? next = current == null ? true : current == true ? false : null;

    final newMap = Map<String, bool?>.from(state.statusSiswa)
      ..[namaSiswa] = next;
    emit(state.copyWith(statusSiswa: newMap));
  }

}
