import 'package:pinterest_clone/features/home/data/datasources/home_remote_datasource.dart';
import 'package:pinterest_clone/features/home/data/models/photo_model.dart';
import 'package:pinterest_clone/features/home/domain/repositories/home_repository.dart';

class MyRepository implements HomeRepository {
  final HomeRemoteDataSource remoteDatasource;
  MyRepository(this.remoteDatasource);

  @override
  Future<List<PhotoModel>> getPhotos({required int page}) {
    return remoteDatasource.fetchPhotos(page: page);
  }
}

