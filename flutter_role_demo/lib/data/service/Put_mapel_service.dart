import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_role_demo/Model/put_mapel/put_mapel.dart';
import 'package:flutter_role_demo/data/local_storange/local_storange.dart';


class PutMapelService {
  final Dio updateMapel = Dio(
    BaseOptions(
      connectTimeout: Duration(seconds: 10),
      receiveTimeout: Duration(seconds: 10),
    ),
  );

  PutMapelService() {
    updateMapel.interceptors.add( // interceptors CCTV
      LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        error: true,
      ),
    );
  }

  Future<Either<String, PutMapel>> updateMapelClass({
    required int id,
    required String nama,
    required int classroomId,
  }) async {
    try {
      final token = await LocalStorage().getToken();
      updateMapel.options.headers['Authorization'] = 'Bearer $token';

      final response = await updateMapel.put(
        'https://absensi.lexspra.my.id/api/pelajarans/$id',
        data: {
          'nama': nama,
          'code': _generateCode(nama),
          'start_time': '08:00:00',
          'end_time': '09:00:00',
          'classroom_id': classroomId,
        },
      );

      final mapelResponse = PutMapel.fromMap(response.data);
      return Right(mapelResponse);
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

  String _generateCode(String nama) {
    return nama
        .toUpperCase()
        .split(' ')
        .map((word) => word.substring(0, 1))
        .join();
  }
}
