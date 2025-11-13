import 'package:dio/dio.dart';
import 'package:electronic_approval/user/provider/token_provider.dart';

class CustomInterceptor extends Interceptor {
  late final Token _token;
  final Dio _dio;

  CustomInterceptor(this._token, this._dio);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final isAccessTokenExists = options.headers['access_token'];

    if (isAccessTokenExists) {
      final accessToken = await _token.getAccessToken();

      options.headers.addAll({'authorization': 'Bearer $accessToken'});
    }
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    var is401Error = err.response?.statusCode == 401;
    var path = err.requestOptions.path;

    if (is401Error && path == '/api/users/login') {
      return handler.reject(err);
    }

    try {
      final refreshToken = await _token.getRefreshToken();
      if (refreshToken == null) {
        return handler.reject(err);
      }
      var options = err.requestOptions;

      final resp = await _dio.post(
        '/users/refresh',
        options: Options(headers: {'refresh_token': refreshToken}),
      );

      final accessToken = resp.data['access_token'];

      _token.saveAccessToken(accessToken);

      options.headers.addAll({'authorization': 'Bearer $accessToken'});

      var response = await _dio.fetch(options);

      return handler.resolve(response);
    } catch (e) {
      await _token.deleteAllTokens();

      return handler.reject(err);
    }
  }
}
