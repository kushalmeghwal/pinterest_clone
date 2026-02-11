import 'package:flutter/foundation.dart';
import 'package:pinterest_clone/core/network/dio_client.dart';
import 'package:pinterest_clone/features/home/data/models/photo_model.dart';

class HomeRemoteDataSource {
  final DioClient dioClient;
  HomeRemoteDataSource(this.dioClient);

  Future<List<PhotoModel>> fetchPhotos() async {
    final response = await dioClient.dio.get("curated?page=1&per_page=60");
    final List photos = response.data['photos'];
    if (kDebugMode) {
      for (final photo in photos) {
        print('id : ${photo['id']}');
        print('src/medium : ${photo['src']['medium']}');
        print('liked : ${photo['liked']}');
      }
    }
    return photos.map((e) => PhotoModel.fromJson(e)).toList();
  }
}
