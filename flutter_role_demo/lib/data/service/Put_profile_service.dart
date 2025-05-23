import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_role_demo/Model/put_profile/put_profile.dart';
import 'package:flutter_role_demo/data/local_storange/local_storange.dart';


class PutProfileService {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://absensi.lexspra.my.id/api',
      connectTimeout: Duration(seconds: 10),
      receiveTimeout: Duration(seconds: 10),
    ),
  );

  Future<Either<String, PutProfile>> updateProfile({
    required int id,
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final token = await LocalStorage().getToken();

      dio.options.headers['Authorization'] = 'Bearer $token';
      dio.options.headers['Content-Type'] = 'application/json';

      final response = await dio.put(
        '/user/$id',
        data: {
          'name': name,
          'email': email,
          'password': password,
        },
      );

      final data = PutProfile.fromMap(response.data);

      return Right(data);
    } on DioException catch (e) {
      final status = e.response?.statusCode;
      final message = e.response?.data['message'] ?? 'Terjadi kesalahan';
      return Left('Error [$status]: $message');
    } catch (e) {
      return Left('Gagal memperbarui profil: $e');
    }
  }
}
