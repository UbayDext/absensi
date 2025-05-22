import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_role_demo/Model/get_student/datum.dart';
import 'package:flutter_role_demo/Model/get_student/get_student.dart';
import 'package:flutter_role_demo/data/network/Dio_client_network.dart';


class GetStudentService {
  final Dio _dio = DioClient.dio;

  Future<Either<String, List<Datum>>> getStudentAttend() async {
    try {
      final response = await _dio.get('/absensi');

      print("📦 Status: ${response.statusCode}");
      print("📦 Full Data: ${response.data}");

      final result = GetStudent.fromMap(response.data);

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
