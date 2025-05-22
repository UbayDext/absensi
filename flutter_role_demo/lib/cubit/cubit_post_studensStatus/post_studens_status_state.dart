// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:flutter_role_demo/Model/post_student_h/post_student.dart';

class PostStudensStatusState extends Equatable {
  final List<PostStudentH> postStudentHList;
  final bool butLoading;
  final String butError;

  const PostStudensStatusState({
    this.postStudentHList = const [],
    this.butLoading = false,
    this.butError = '',
  });

  @override
  List<Object> get props => [postStudentHList, butLoading, butError];

  PostStudensStatusState copyWith({
    List<PostStudentH>? postStudentHList,
    bool? butLoading,
    String? butError,
  }) {
    return PostStudensStatusState(
      postStudentHList: postStudentHList ?? this.postStudentHList,
      butLoading: butLoading ?? this.butLoading,
      butError: butError ?? this.butError,
    );
  }
}
