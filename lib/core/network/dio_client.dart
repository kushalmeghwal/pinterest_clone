import 'package:dio/dio.dart';
import 'package:pinterest_clone/core/constants/api_constants.dart';

class DioClient {
  final Dio dio;

  DioClient()
      : dio = Dio(
          BaseOptions(
            baseUrl: ApiConstants.baseUrl,
            headers: {
              "Authorization": ApiConstants.apiKey,
            },
          ),
        );
}
