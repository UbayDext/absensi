import 'package:bloc/bloc.dart';

import 'package:flutter_role_demo/cubit/cubit_deleted_mapela/deleted_mapela_state.dart';
import 'package:flutter_role_demo/data/service/Deleted_mapel_service.dart';

class DeletedMapelaCubit extends Cubit<DeletedMapelaState> {
  DeletedMapelaCubit() : super(DeletedMapelaState());

  Future<void> toDeletedMapel(int id) async {
    emit(state.copyWith(ikLoading: true));

    final result = await DeletedMapelService().DeletedDataMapel(id);

    result.fold((left) => emit(state.copyWith(ikError: left)), (right) {
      emit(state.copyWith(responseDelet: right));
      print('✅ Data dihapus: ${right.message}');
    });
    emit(state.copyWith(ikLoading: false));
  }

  void reser() {
    emit(const DeletedMapelaState());
  }
}
