import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_role_demo/Model/kelas_get/kelas_get.dart';
import 'package:flutter_role_demo/data/local_storange/local_storange.dart';

class GetKelasService {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://absensi.lexspra.my.id/api',
      connectTimeout: Duration(seconds: 5),
      receiveTimeout: Duration(seconds: 5),
    ),
  );

  Future<Either<String, List<KelasGet>>> getAllClassrooms() async {
    try {
      final token = await LocalStorage().getToken();
      dio.options.headers['Authorization'] = 'Bearer $token';

      final response = await dio.get('/classrooms');

      final List<KelasGet> data = (response.data as List)
          .map((item) => KelasGet.fromMap(item))
          .toList();

      return Right(data);
    } on DioException catch (e) {
      final status = e.response?.statusCode;
      final message = e.response?.data.toString() ?? 'Unknown Dio error';
      return Left('Error [$status]: $message');
    } catch (e) {
      return Left('Gagal mengambil data kelas: $e');
    }
  }
}
