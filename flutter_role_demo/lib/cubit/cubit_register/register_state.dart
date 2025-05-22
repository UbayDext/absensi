// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:flutter_role_demo/Model/register/register.dart';
import 'package:flutter_role_demo/data/service/register_service.dart';

class RegisterState extends Equatable {
  const RegisterState({
    this.registerRespone = const Register(),
    this.ifError = '',
    this.ifLoading = false,
  });
  final Register registerRespone;
  final bool ifLoading;
  final String ifError;

  @override
  List<Object?> get props => [registerRespone, ifLoading, ifError];

  RegisterState copyWith({
    Register? registerRespone,
    bool? ifLoading,
    String? ifError,
  }) {
    return RegisterState(
      registerRespone: registerRespone ?? this.registerRespone,
      ifLoading: ifLoading ?? this.ifLoading,
      ifError: ifError ?? this.ifError,
    );
  }
}
