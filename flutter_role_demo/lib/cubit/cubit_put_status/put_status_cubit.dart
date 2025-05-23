import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_role_demo/Model/put_studend/put_studend.dart';
import 'package:flutter_role_demo/cubit/cubit_put_status/put_status_state.dart';
import 'package:flutter_role_demo/data/service/put_student_service.dart';

class PutStudensStatusCubit extends Cubit<PutStudensStatusState> {
  final PutStudentService service;

  PutStudensStatusCubit({required this.service})
      : super(const PutStudensStatusState());

  Future<bool> updateStatus({
    required int id,
    required String name,
    required String status,
    int? userId,
    required int pelajaranId,
    required int classroomId,
    required DateTime date,
  }) async {
    emit(state.copyWith(igLoading: true));

    final result = await service.upadtestudent(
      id: id,
      name: name,
      status: status,
      userId: userId,
      pelajaranId: pelajaranId,
      classroomId: classroomId,
      date: date,
    );

    return result.fold(
      (errorMsg) {
        emit(state.copyWith(igLoading: false, igError: errorMsg));
        print("❌ Error dari API PUT: $errorMsg");
        return false;
      },
      (data) {
        emit(state.copyWith(igLoading: false, updateSiswa: data));
        print("✅ Berhasil update data siswa: ${data.data?.name}");
        return true;
      },
    );
  }
}
