import 'package:bloc/bloc.dart';
import 'package:flutter_role_demo/cubit/cubit_deleted_class/deleted_class_state.dart';
import 'package:flutter_role_demo/data/service/Deleted_service.dart';


class DeleteClassCubit extends Cubit<DeleteClassState> {
  DeleteClassCubit() : super(const DeleteClassState());

  Future<void> toDeleteClass(int id) async {
    emit(state.copyWith(itLoading: true));

    final result = await DeleteClassService().deleteClassroom(id);

    result.fold(
      (left) => emit(state.copyWith(iterror: left)),
      (right) {
        emit(state.copyWith(responseDeleted: right));
        print('✅ Data dihapus: ${right.message}');
      },
    );

    emit(state.copyWith(itLoading: false));
  }

  void reset() {
    emit(const DeleteClassState());
  }
}
