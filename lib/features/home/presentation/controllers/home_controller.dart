import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinterest_clone/features/home/domain/repositories/home_repository.dart';
import 'package:pinterest_clone/features/home/presentation/controllers/home_state.dart';
import 'package:pinterest_clone/features/home/presentation/providers/home_provider.dart';

class HomeController extends Notifier<HomeState> {
  late final HomeRepository repository;

  int _page = 1;

  @override
  HomeState build() {
    repository = ref.read(homeRepositoryProvider);
    return HomeState(photos: [], isLoading: true);
  }

  Future<void> loadInitial() async {

  _page = 1;
  state = state.copyWith(isLoading: true);

  try {
      print("🚨 CALLING REPOSITORY");
    final photos = await repository.getPhotos(page: _page);
      print("🚨 PHOTOS LENGTH: ${photos.length}");
    state = HomeState(
      photos: photos,
      isLoading: false,
    );

      print("🚨 STATE UPDATED");
  } catch (e) {
    print("🚨🚨🚨ERROR: $e");
    state = HomeState(
      photos: [],
      isLoading: false,
    );
  }
}


  Future<void> loadMore() async {
    if (state.isLoading) return;
    state = state.copyWith(isLoading: true);
    _page++;

    final newPhotos = await repository.getPhotos(page: _page);
    state = HomeState(
      photos: [...state.photos, ...newPhotos],
      isLoading: false,
    );
  }
}
