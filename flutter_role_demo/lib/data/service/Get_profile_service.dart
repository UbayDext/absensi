import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_role_demo/Model/get_profile/data.dart';
import 'package:flutter_role_demo/data/local_storange/local_storange.dart';

class GetProfileService {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://absensi.lexspra.my.id/api',
      connectTimeout: Duration(seconds: 5),
      receiveTimeout: Duration(seconds: 5),
    ),
  );

 Future<Either<String, Data>> getProfile() async {
  try {
    final token = await LocalStorage().getToken();
    dio.options.headers['Authorization'] = 'Bearer $token';

    final response = await dio.get('/user');

    final Map<String, dynamic> responseData = response.data;
    final profile = Data.fromMap(responseData['data']);

    return Right(profile);
  } on DioException catch (e) {
    final status = e.response?.statusCode;
    final message = e.response?.data.toString() ?? 'Unknown Dio error';
    return Left('Error [$status]: $message');
  } catch (e) {
    return Left('Gagal mengambil data profil: $e');
  }
}

}
