// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class DataSiswaKelasState extends Equatable {
  const DataSiswaKelasState({
    this.siswa = const [],
    this.statusSiswa = const {}
    });

  final List<String> siswa;
  final Map<String, bool?> statusSiswa;

  @override
  List<Object> get props => [siswa, statusSiswa];

  DataSiswaKelasState copyWith({
    List<String>? siswa,
    Map<String, bool?>? statusSiswa,
  }) {
    return DataSiswaKelasState(
      siswa: siswa ?? this.siswa,
      statusSiswa: statusSiswa ?? this.statusSiswa,
    );
  }
}

