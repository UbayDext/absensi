import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_role_demo/cubit/cubit_put_mapel/put_mapel_state.dart';
import 'package:flutter_role_demo/data/service/Put_mapel_service.dart';

class PutMapelCubit extends Cubit<PutMapelState> {
  final PutMapelService _service;

  PutMapelCubit(this._service) : super(const PutMapelState());

  Future<void> updateMapel({
    required int id,
    required String nama,
    required int classroomId,
  }) async {
    emit(state.copyWith(igLoading: true, igError: ''));

    final result = await _service.updateMapelClass(
      id: id,
      nama: nama,
      classroomId: classroomId,
    );

    result.fold(
      (errorMsg) => emit(state.copyWith(igLoading: false, igError: errorMsg)),
      (data) => emit(state.copyWith(igLoading: false, updateMapel: data)),
    );
  }
}
