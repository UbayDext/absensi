import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_role_demo/Model/deleted_class.dart';
import 'package:flutter_role_demo/data/local_storange/local_storange.dart';

class DeleteClassService {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://absensi.lexspra.my.id/api',
      connectTimeout: Duration(seconds: 10),
      receiveTimeout: Duration(seconds: 10),
    ),
  );

  Future<Either<String, DeletedClass>> deleteClassroom(int id) async {
    try {
      final token = await LocalStorage().getToken();
      dio.options.headers['Authorization'] = 'Bearer $token';

      final response = await dio.delete('/classrooms/$id');

      final data = DeletedClass.fromMap(response.data);
      return Right(data);
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
