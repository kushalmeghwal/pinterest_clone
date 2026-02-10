import 'package:pinterest_clone/core/network/dio_client.dart';
import 'package:pinterest_clone/features/home/data/models/photo_model.dart';

class HomeRemoteDataSource {
  final DioClient dioClient;
  HomeRemoteDataSource(this.dioClient);

  Future<List<PhotoModel>> fetchPhotos() async {
    final response = await dioClient.dio.get("curated?page=1&per_page=30");
    final List photos = response.data['photos'];
    return photos.map((e) => PhotoModel.fromJson(e)).toList();
  }
}
