// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

class CrudKelasState extends Equatable {
  const CrudKelasState({this.kelas = const []});

  final List<String> kelas;

  @override
  List<Object> get props => [kelas];

  CrudKelasState copyWith({List<String>? kelas}) {
    return CrudKelasState(kelas: kelas ?? this.kelas);
  }
}
