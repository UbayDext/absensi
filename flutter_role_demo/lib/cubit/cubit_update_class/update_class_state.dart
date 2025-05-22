// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';
import 'package:flutter_role_demo/Model/upadate_class/upadate_class.dart';

class UpdateClassState extends Equatable {
  const UpdateClassState({
    this.updateClass = const UpadateClass(),
    this.butLoading = false,
    this.butError = '',
  });
  final UpadateClass updateClass;
  final bool butLoading;
  final String butError;
  @override
  List<Object> get props => [updateClass, butLoading, butError];

  UpdateClassState copyWith({
    UpadateClass? updateClass,
    bool? butLoading,
    String? butError,
  }) {
    return UpdateClassState(
      updateClass: updateClass ?? this.updateClass,
      butLoading: butLoading ?? this.butLoading,
      butError: butError ?? this.butError,
    );
  }
}
