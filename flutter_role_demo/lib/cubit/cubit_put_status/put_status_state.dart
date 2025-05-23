// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:flutter_role_demo/Model/put_studend/put_studend.dart';

class PutStudensStatusState extends Equatable {
  const PutStudensStatusState({
    this.updateSiswa = const PutStudend(),
    this.igLoading = false,
    this.igError = '',
  });

  final PutStudend updateSiswa;
  final bool igLoading;
  final String igError;

  @override
  List<Object> get props => [updateSiswa, igLoading, igError];

  PutStudensStatusState copyWith({
    PutStudend? updateSiswa,
    bool? igLoading,
    String? igError,
  }) {
    return PutStudensStatusState(
      updateSiswa: updateSiswa ?? this.updateSiswa,
      igLoading: igLoading ?? this.igLoading,
      igError: igError ?? this.igError,
    );
  }
}
