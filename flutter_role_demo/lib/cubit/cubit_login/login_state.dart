// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:flutter_role_demo/Model/login/login.dart';

class LoginState extends Equatable {
  const LoginState({
    this.loginResponse = const Login(),
    this.isLoading = false,
    this.error = '',
  });

  final Login loginResponse;
  final bool isLoading;
  final String error;

  @override
  List<Object?> get props => [loginResponse, isLoading, error];

  LoginState copyWith({Login? loginResponse, bool? isLoading, String? error}) {
    return LoginState(
      loginResponse: loginResponse ?? this.loginResponse,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}
