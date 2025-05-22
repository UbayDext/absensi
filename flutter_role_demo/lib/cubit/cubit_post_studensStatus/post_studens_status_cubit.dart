import 'package:bloc/bloc.dart';
import 'package:flutter_role_demo/Model/post_student_h/post_student.dart';
import 'package:flutter_role_demo/cubit/cubit_post_studensStatus/post_studens_status_state.dart';
import 'package:flutter_role_demo/data/service/Post_student_service.dart';

class PostStudensStatusCubit extends Cubit<PostStudensStatusState> {
  final PostStudentService service;

  PostStudensStatusCubit({required this.service})
      : super(const PostStudensStatusState());

  Future<PostStudentH?> addStatus({
    required String name,
    required String status,
    int? userId,
    required int pelajaranId,
    required int classroomId,
    required DateTime date,
  }) async {
    emit(state.copyWith(butLoading: true));

    final result = await service.submitAbsensi(
      name: name.trim(),
      status: status,
      userId: userId,
      pelajaranId: pelajaranId,
      classroomId: classroomId,
      date: date,
    );

    return result.fold(
      (error) {
        print('❌ Error dari API: $error');
        emit(state.copyWith(butError: error, butLoading: false));
        return null;
      },
      (data) {
        final updatedList = List<PostStudentH>.from(state.postStudentHList)..add(data);
        emit(state.copyWith(
          postStudentHList: updatedList,
          butLoading: false,
          butError: '',
        ));
        return data;
      },
    );
  }

  List<PostStudentH> getAbsensiByClassAndPelajaran({
    required int classroomId,
    required int pelajaranId,
  }) {
    return state.postStudentHList
        .where(
          (e) =>
              e.data?.classroomId == classroomId &&
              e.data?.pelajaranId == pelajaranId,
        )
        .toList();
  }
}