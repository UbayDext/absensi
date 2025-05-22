import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_role_demo/Model/kelas_add/kelas_add.dart';

import 'package:flutter_role_demo/cubit/cubit_data_kelas_siswa/data_siswa_kelas_state.dart';
import 'package:flutter_role_demo/data/service/crud_kelas_service.dart';

class DataSiswaKelasCubit extends Cubit<DataSiswaKelasState> {
  DataSiswaKelasCubit() : super(const DataSiswaKelasState());

  Future<KelasAdd?> tambahSiswa(String name) async {
    emit(state.copyWith(isLoading: true));

    final add = await CrudKelasService().addKelas(name: name);

    return add.fold(
      (left) {
        emit(state.copyWith(isError: left, isLoading: false));
        return null;
      },
      (right) {
        final updatedList = List<KelasAdd>.from(state.daftarSiswa)..add(right);
        emit(
          state.copyWith(
            daftarSiswa: updatedList,
            isLoading: false,
            isError: '',
          ),
        );
        return right; // ✅ return objek
      },
    );
  }
}
