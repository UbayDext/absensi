import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_role_demo/Model/get_mapel/datum.dart';
import 'package:flutter_role_demo/Model/get_mapel/get_mapel.dart';
import 'package:flutter_role_demo/data/local_storange/local_storange.dart';


class GetMapelService {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://absensi.lexspra.my.id/api',
      connectTimeout: Duration(seconds: 5),
      receiveTimeout: Duration(seconds: 5),
    ),
  );

  Future<Either<String, List<Datum>>> fetchMapel() async {
    try {
      final token = await LocalStorage().getToken();
      dio.options.headers['Authorization'] = 'Bearer $token';

      final response = await dio.get('/pelajarans');
      print("📦 Status: ${response.statusCode}");
      print("📦 Full Data: ${response.data}");

      final result = GetMapel.fromMap(response.data);

      if (result.success == true && result.data != null) {
        print("✅ Jumlah pelajaran: ${result.data!.length}");
        return Right(result.data!);
      } else {
        return Left(result.message ?? 'Gagal mengambil data pelajaran.');
      }
    } on DioException catch (e) {
      final status = e.response?.statusCode;
      final message = e.response?.data.toString() ?? 'Unknown Dio error';
      print('❌ Dio error [$status]: $message');
      return Left('Error [$status]: $message');
    } catch (e) {
      print('❌ General error: $e');
      return Left('Gagal mengambil data pelajaran: $e');
    }
  }
}
