import 'package:bloc/bloc.dart';
import 'package:flutter_role_demo/cubit/cubit_get_studen/get_studen_state.dart';
import 'package:flutter_role_demo/data/service/Get_student_service.dart';

class GetStudenCubit extends Cubit<GetStudenState> {
  final GetStudentService getStudentService;
  GetStudenCubit({required this.getStudentService})
    : super(const GetStudenState());

  Future<void> getAllStudent() async {
    emit(state.copyWith(butLoading: true, butError: ''));

    final result = await getStudentService.getStudentAttend();

    result.fold(
      (error) {
        emit(state.copyWith(butLoading: false, butError: error));
      },
      (studentList) {
        emit(state.copyWith(attandenceStudent: studentList, butLoading: false));
      },
    );
  }
}
