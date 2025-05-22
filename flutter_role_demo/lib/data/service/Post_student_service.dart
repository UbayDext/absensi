import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_role_demo/Model/post_student_h/post_student.dart';
import 'package:flutter_role_demo/data/local_storange/local_storange.dart';

class PostStudentService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://absensi.lexspra.my.id/api',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

  PostStudentService() {
    _dio.interceptors.add(
      LogInterceptor(request: true, requestBody: true, responseBody: true),
    );
  }

  Future<Either<String, PostStudentH>> submitAbsensi({
    required String name,
    required String status,
    int? userId,
    required int pelajaranId,
    required int classroomId,
    required DateTime date,
  }) async {
    try {
      final token = await LocalStorage().getToken();
      _dio.options.headers['Authorization'] = 'Bearer $token';

      final data = {
        'name': name,
        'status': status,
        'pelajaran_id': pelajaranId,
        'classroom_id': classroomId,
        'date': date.toIso8601String().split('T')[0],
        'check_in_time': '08:00:00',
        'check_out_time': '09:00:00',
        'notes': null,
      };

      if (userId != null) {
        data['user_id'] = userId;
      }

      final response = await _dio.post('/absensi', data: data);

      print('✅ API Response: ${response.data}');

      if (response.statusCode == 201 || response.statusCode == 200) {
        final result = PostStudentH.fromMap(response.data);
        return Right(result);
      } else {
        return Left("Error ${response.statusCode}: ${response.statusMessage}");
      }
    } on DioException catch (e) {
      final msg = e.response?.data['message'] ?? e.message;
      print('❌ Gagal POST: ${e.response?.data}');
      return Left("❌ Dio error: $msg");
    } catch (e) {
      return Left("❌ General error: \${e.toString()}");
    }
  }
}