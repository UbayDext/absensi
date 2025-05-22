import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_role_demo/Model/kelas_add/kelas_add.dart';
import 'package:flutter_role_demo/data/local_storange/local_storange.dart';


class CrudKelasService {
  final Dio siswa = Dio(
    BaseOptions(
      baseUrl: 'https://absensi.lexspra.my.id/api',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

  CrudKelasService() {
    siswa.interceptors.add(
      LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: false,
        responseBody: true,
        error: true,
      ),
    );
  }

  Future<Either<String, KelasAdd>> addKelas({required String name}) async {
    try {
      // Jika API pakai auth Sanctum, tambahkan token
      final token = await LocalStorage().getToken();
      siswa.options.headers['Authorization'] = 'Bearer $token';

      final response = await siswa.post('/classrooms', data: {
        "name": name,
      });

      print("📦 Status: ${response.statusCode}");
      print("📦 Full Data: ${response.data}");

      final kelasResponse = KelasAdd.fromMap(response.data);
      return Right(kelasResponse);
    } on DioException catch (e) {
      print("❌ Dio error [${e.response?.statusCode}]: ${e.message}");
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
}
