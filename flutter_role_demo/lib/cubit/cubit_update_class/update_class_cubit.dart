import 'package:bloc/bloc.dart';
import 'package:flutter_role_demo/cubit/cubit_update_class/update_class_state.dart';
import 'package:flutter_role_demo/data/service/update_class_service.dart';


class UpdateClassCubit extends Cubit<UpdateClassState> {
  UpdateClassCubit() : super(const UpdateClassState());

  Future<void> toUpdateClass({required int id, required String name}) async {
    emit(state.copyWith(butLoading: true));

    final result = await UpdateClassService().updateClassroom(id: id, name: name);

    result.fold(
      (left) => emit(state.copyWith(butError: left)),
      (right) {
        emit(state.copyWith(updateClass: right));
        print('✅ Kelas berhasil diupdate: ${right.data?.name}');
      },
    );

    emit(state.copyWith(butLoading: false));
  }
}
