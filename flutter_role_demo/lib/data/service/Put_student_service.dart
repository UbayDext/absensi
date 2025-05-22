import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_role_demo/Model/put_studend/put_studend.dart';

import 'package:flutter_role_demo/data/local_storange/local_storange.dart';

class PutStudentService {
  final Dio updateStatusStudent = Dio(
    BaseOptions(
      connectTimeout: Duration(seconds: 5),
      receiveTimeout: Duration(seconds: 5),
    ),
  );

  PutStudentService() {
    updateStatusStudent.interceptors.add(
      LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        error: true,
      ),
    );
  }

  Future<Either<String, PutStudend>> upadteStudent({
    required int id,
    required String name,
    required String status,
    int? userId,
    required int pelajaranId,
    required int classroomId,
    required DateTime date,
  }) async {
    try {
      final token = await LocalStorage().getToken();
      updateStatusStudent.options.headers['Authorization'] = 'Bearer $token';

      final response = await updateStatusStudent.put(
        'https://absensi.lexspra.my.id/api/absensi/$id',
        data: {
           'name': name,
        'status': status,
        'pelajaran_id': pelajaranId,
        'classroom_id': classroomId,
        'date': date.toIso8601String().split('T')[0],
        'check_in_time': '08:00:00',
        'check_out_time': '09:00:00',
        'notes': null,
        },
      );

      final statusResponse = PutStudend.fromMap(response.data);
      return Right(statusResponse);
    } on DioException catch (e) {
      if (e.response != null) {
        final code = e.response?.statusCode;
        final data = e.response?.data;

        String message = 'Unknown error';
        if (data is Map && data.containsKey('message')) {
          message = data['message'];
        } else if (data is String) {
          message = data;
        }

        return Left('Error [$code] : $message');
      } else {
        return Left('Connection error: ${e.message}');
      }
    } catch (e) {
      return Left('Unhandled error: ${e.toString()}');
    }
  }
}
