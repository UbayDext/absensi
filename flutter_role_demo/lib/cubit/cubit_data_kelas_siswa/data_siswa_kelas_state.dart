// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter_role_demo/Model/kelas_add/kelas_add.dart';



class DataSiswaKelasState extends Equatable {
  final List<KelasAdd> daftarSiswa;
  final bool isLoading;
  final String isError;

  const DataSiswaKelasState({
    this.daftarSiswa = const [],
    this.isLoading = false,
    this.isError = '',
  });

  @override
  List<Object> get props => [daftarSiswa, isLoading, isError];

  DataSiswaKelasState copyWith({
    List<KelasAdd>? daftarSiswa,
    bool? isLoading,
    String? isError,
  }) {
    return DataSiswaKelasState(
      daftarSiswa: daftarSiswa ?? this.daftarSiswa,
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
    );
  }
}

