// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter_role_demo/Model/kelas_get/kelas_get.dart';



class GetDataKelasState extends Equatable {
  const GetDataKelasState({
    this.classData = const [],
    this.isLoading = false,
    this.isError = '',
  });

  final List<KelasGet> classData;
  final bool isLoading;
  final String isError;

  @override
  List<Object> get props => [classData, isLoading, isError];

  GetDataKelasState copyWith({
    List<KelasGet>? classData,
    bool? isLoading,
    String? isError,
  }) {
    return GetDataKelasState(
      classData: classData ?? this.classData,
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
    );
  }
}
