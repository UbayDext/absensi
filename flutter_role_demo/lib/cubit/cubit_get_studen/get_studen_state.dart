// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:flutter_role_demo/Model/get_student/datum.dart';

class GetStudenState extends Equatable {
  const GetStudenState({
    this.attandenceStudent = const [],
    this.butLoading = false,
    this.butError = '',
  });

  final List<Datum> attandenceStudent;
  final bool butLoading;
  final String butError;

  @override
  List<Object> get props => [attandenceStudent, butLoading, butError];

  GetStudenState copyWith({
    List<Datum>? attandenceStudent,
    bool? butLoading,
    String? butError,
  }) {
    return GetStudenState(
      attandenceStudent: attandenceStudent ?? this.attandenceStudent,
      butLoading: butLoading ?? this.butLoading,
      butError: butError ?? this.butError,
    );
  }
}


