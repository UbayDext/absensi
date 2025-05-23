import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_role_demo/Model/post_pelajaran/post_pelajaran.dart';
import 'package:flutter_role_demo/data/local_storange/local_storange.dart';

class PostPelajaranService {
  final Dio Mapel = Dio(
    BaseOptions(
      baseUrl: 'https://absensi.lexspra.my.id/api',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

  PostPelajaranService() {
    Mapel.interceptors.add(
      LogInterceptor( // print data
        request: true,
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        error: true,
      ),
    );
  }

  Future<Either<String, PostPelajaran>> addMapel({
    required String nama,
    required int classroomId,
  }) async {
    try {
      final token = await LocalStorage().getToken();
      Mapel.options.headers['Authorization'] = 'Bearer $token';

      final response = await Mapel.post(
        '/pelajarans',
        data: {
          'nama': nama,
          'code': _generateCode(nama),
          'start_time': '08:00:00',
          'end_time': '09:00:00',
          'classroom_id': classroomId,
        },
      );

      print("📦 Status: ${response.statusCode}");
      print("📦 FULL Data: ${response.data}");

      final mapelResponse = PostPelajaran.fromMap(response.data);
      return Right(mapelResponse);
    } on DioException catch (e) {
      print("❌ Dio error [${e.response?.statusCode}]");
      print("❌ Dio exception type: ${e.type}");

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
        return Left('Connection error: ${e.message ?? "Tidak diketahui"}');
      }
    } catch (e) {
      return Left('Unhandled error: ${e.toString()}');
    }
  }

  String _generateCode(String nama) {
    return nama
        .toUpperCase()
        .split(' ')
        .map((word) => word.substring(0, 1))
        .join();
  }
}
