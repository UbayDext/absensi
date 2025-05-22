import 'package:dio/dio.dart';
import 'package:flutter_role_demo/data/local_storange/local_storange.dart';

class DioClient {
  static final Dio _dio = Dio(
      BaseOptions(
        baseUrl: 'https://absensi.lexspra.my.id/api',
        connectTimeout: Duration(seconds: 5),
        receiveTimeout: Duration(seconds: 5),
      ),
    )
    ..interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await LocalStorage().getToken();
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
        onError: (DioException e, handler) async {
          print("❌ Interceptor caught error: ${e.response?.statusCode}");
          return handler.next(e);
        },
      ),
    );

  static Dio get dio => _dio;
}
