import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_role_demo/Model/login/login.dart';

class LoginService {
  final acces = Dio(
    BaseOptions(
      connectTimeout: Duration(seconds: 30),
      receiveTimeout: Duration(seconds: 30),
    ),
  );

  Future<Either<String, Login>> login({
    required String email,
    required String password,
  }) async {
    try {
      var response = await acces.post(
        'https://absensi.lexspra.my.id/api/login',
        data: {"email": email, "password": password},
      );

      var dataResponse = Login.fromMap(response.data);
      return Right(dataResponse);
    } on DioException catch (e) {
      if (e.response != null) {
        var statusCode = e.response?.statusCode;
        var message = e.response?.data['message'] ?? 'Unknown error';
        return Left('Error [$statusCode] : $message');
      } else {
        return Left('Connection error: ${e.message}');
      }
    }
  }
}
