import 'package:equatable/equatable.dart';
import 'package:flutter_role_demo/Model/put_profile/put_profile.dart';

class PutProfileState extends Equatable {
  final bool isLoading;
  final String error;
  final PutProfile? data;

  const PutProfileState({
    this.isLoading = false,
    this.error = '',
    this.data,
  });

  PutProfileState copyWith({
    bool? isLoading,
    String? error,
    PutProfile? data,
  }) {
    return PutProfileState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }

  @override
  List<Object?> get props => [isLoading, error, data];
}
