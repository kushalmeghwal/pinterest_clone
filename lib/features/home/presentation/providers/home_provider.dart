import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinterest_clone/core/network/dio_client.dart';
import 'package:pinterest_clone/features/home/data/models/photo_model.dart';
import 'package:pinterest_clone/features/home/data/datasources/home_remote_datasource.dart';
import 'package:pinterest_clone/features/home/data/repositories/my_repository.dart';
import 'package:pinterest_clone/features/home/domain/repositories/home_repository.dart';


final dioProvider = Provider((ref) => DioClient());

final homeRemoteDataSourceProvider =
    Provider((ref) => HomeRemoteDataSource(ref.read(dioProvider)));

final homeRepositoryProvider = Provider<HomeRepository>(
  (ref) => MyRepository(ref.read(homeRemoteDataSourceProvider)),
);

final homePhotosProvider = FutureProvider<List<PhotoModel>>((ref) async {
  final repo = ref.read(homeRepositoryProvider);
  return repo.getPhotos();
});
