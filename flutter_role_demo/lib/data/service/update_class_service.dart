import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_role_demo/Model/upadate_class/upadate_class.dart';
import 'package:flutter_role_demo/data/local_storange/local_storange.dart';

class UpdateClassService {
  final Dio acces = Dio(
    BaseOptions(
      connectTimeout: Duration(seconds: 10),
      receiveTimeout: Duration(seconds: 10),
    ),
  );

  Future<Either<String, UpadateClass>> updateClassroom({
    required int id,
    required String name,
  }) async {
    try {
      final token = await LocalStorage().getToken();
      acces.options.headers['Authorization'] = 'Bearer $token';

      final response = await acces.put(
        'https://absensi.lexspra.my.id/api/classrooms/$id',
        data: {"name": name},
      );

      final dataResponse = UpadateClass.fromMap(response.data);
      return Right(dataResponse);
    } on DioException catch (e) {
      if (e.response != null) {
        final statusCode = e.response?.statusCode;
        final message = e.response?.data['message'] ?? 'Unknown error';
        return Left('Error [$statusCode] : $message');
      } else {
        return Left('Connection error: ${e.message}');
      }
    }
  }
}
