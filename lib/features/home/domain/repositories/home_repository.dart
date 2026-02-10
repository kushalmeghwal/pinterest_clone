import 'package:pinterest_clone/features/home/data/models/photo_model.dart';

abstract class HomeRepository {
  Future<List<PhotoModel>> getPhotos();
}
