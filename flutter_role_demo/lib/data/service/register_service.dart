import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_role_demo/Model/register/register.dart';

class RegisterService {
  final Dio _dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
    ),
  );

  Future<Either<String, Register>> register({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) async {
    try {
      final response = await _dio.post(
        'https://absensi.lexspra.my.id/api/register',
        data: {
          'name': name,
          'email': email,
          'password': password,
          'password_confirmation': passwordConfirmation,
        },
        options: Options(
          headers: {'Accept': 'application/json'},
        ),
      );

      final registerData = Register.fromMap(response.data);
      return Right(registerData);

    } on DioException catch (e) {
      if (e.response != null) {
        final statusCode = e.response?.statusCode;
        final message = e.response?.data['message'] ?? 'Unknown error';
        return Left('Error [$statusCode]: $message');
      } else {
        return Left('Connection error: ${e.message}');
      }
    }
  }
}
