import 'package:flutter/foundation.dart';
import 'package:pinterest_clone/core/network/dio_client.dart';
import 'package:pinterest_clone/features/home/data/models/photo_model.dart';

class HomeRemoteDataSource {
  final DioClient dioClient;
  HomeRemoteDataSource(this.dioClient);

  Future<List<PhotoModel>> fetchPhotos({required int page}) async {
    final response = await dioClient.dio.get("curated?page=$page&per_page=30");

    if (kDebugMode) {
      print("Full URL: ${response.requestOptions.uri}");
      print("Full Response: ${response.data['next_page']}");
    }
    final List photos = response.data['photos'];
    return photos.map((e) => PhotoModel.fromJson(e)).toList();
  }
}
