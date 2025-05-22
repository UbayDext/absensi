import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_role_demo/Model/post_pelajaran/post_pelajaran.dart';
import 'package:flutter_role_demo/cubit/cubit_Post_mapel/post_mapel_state.dart';
import 'package:flutter_role_demo/data/service/Post_pelajaran_service.dart';


class PostMapelCubit extends Cubit<PostMapelState> {
  PostMapelCubit() : super(PostMapelState());

  /// Menambahkan pelajaran ke server dan update state jika berhasil
  Future<PostPelajaran?> addMapelStud(String name, int classroomId) async {
    emit(state.copyWith(isLoading: true));

    final post = await PostPelajaranService().addMapel(
      nama: name.trim(), // buang spasi di awal/akhir
      classroomId: classroomId,
    );

    return post.fold(
      (left) {
        // gagal
        emit(state.copyWith(isError: left, isLoading: false));
        return null;
      },
      (right) {
        // sukses: tambah ke list
        final addPost = List<PostPelajaran>.from(state.postMapelK)..add(right);
        emit(
          state.copyWith(
            postMapelK: addPost,
            isLoading: false,
            isError: '',
          ),
        );
        return right;
      },
    );
  }

  /// Mengembalikan daftar pelajaran berdasarkan `classroomId`
  List<PostPelajaran> getPelajaranByClass(int classroomId) {
    return state.postMapelK
        .where((e) => e.data?.classroomId == classroomId)
        .toList();
  }
}
