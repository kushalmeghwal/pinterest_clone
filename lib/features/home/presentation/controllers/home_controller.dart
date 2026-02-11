import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinterest_clone/features/home/data/models/photo_model.dart';
import 'package:pinterest_clone/features/home/domain/repositories/home_repository.dart';
import 'package:pinterest_clone/features/home/presentation/providers/home_provider.dart';

class HomeController extends Notifier<List<PhotoModel>> {
  late final HomeRepository repository;

  int _page = 1;
  bool _isLoading = false;

  @override
  List<PhotoModel> build() {
    repository = ref.read(homeRepositoryProvider);
    loadInitial();
    return [];
  }
  Future<void> loadInitial() async {
    _page = 1;
    final photos = await repository.getPhotos(page: _page);
    state = photos;
  }

  Future<void> loadMore() async {
    if (_isLoading) return;

    _isLoading = true;
    _page++;

    final newPhotos = await repository.getPhotos(page: _page);

    state = [...state, ...newPhotos];

    _isLoading = false;
  }
}
