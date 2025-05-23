// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:flutter_role_demo/Model/login/user.dart';

class GetProfileState extends Equatable {
  const GetProfileState({
    this.user,
    this.isLoading = false,
    this.isError = '',
  });

  final User? user;
  final bool isLoading;
  final String isError;

  @override
  List<Object?> get props => [user, isLoading, isError];

  GetProfileState copyWith({
    User? user,
    bool? isLoading,
    String? isError,
  }) {
    return GetProfileState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
    );
  }
}

