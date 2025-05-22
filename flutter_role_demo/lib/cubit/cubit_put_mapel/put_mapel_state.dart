// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:flutter_role_demo/Model/put_mapel/put_mapel.dart';

class PutMapelState extends Equatable {
  const PutMapelState({
    this.updateMapel = const PutMapel(),
    this.igLoading = false,
    this.igError = '',
  });
  final PutMapel updateMapel;
  final bool igLoading;
  final String igError;

  @override
  List<Object> get props => [updateMapel, igLoading, igError];

  PutMapelState copyWith({
    PutMapel? updateMapel,
    bool? igLoading,
    String? igError,
  }) {
    return PutMapelState(
      updateMapel: updateMapel ?? this.updateMapel,
      igLoading: igLoading ?? this.igLoading,
      igError: igError ?? this.igError,
    );
  }
}
