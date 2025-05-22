// ignore_for_file: public_member_api_docs, sort_constructors_first


import 'package:equatable/equatable.dart';

import 'package:flutter_role_demo/Model/deleted_mapel.dart';

class DeletedMapelaState extends Equatable {
  const DeletedMapelaState({
    this.responseDelet = const DeletedMapel(),
    this.ikLoading = false,
    this.ikError = '',
  });
  final DeletedMapel responseDelet;
  final bool ikLoading;
  final String ikError;

  @override
  List<Object> get props => [responseDelet, ikLoading, ikError];

  DeletedMapelaState copyWith({
    DeletedMapel? responseDelet,
    bool? ikLoading,
    String? ikError,
  }) {
    return DeletedMapelaState(
      responseDelet: responseDelet ?? this.responseDelet,
      ikLoading: ikLoading ?? this.ikLoading,
      ikError: ikError ?? this.ikError,
    );
  }
}


