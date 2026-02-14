import 'package:flutter_riverpod/legacy.dart';
import 'package:pinterest_clone/features/home/domain/repositories/home_repository.dart';
import 'package:pinterest_clone/features/home/presentation/controllers/search_state.dart';
import 'package:pinterest_clone/features/home/presentation/providers/home_provider.dart';

final searchControllerProvider =
    StateNotifierProvider<SearchController, SearchState>((ref) {
  final repo = ref.read(homeRepositoryProvider);
  return SearchController(repo);
});

class SearchController extends StateNotifier<SearchState> {
  final HomeRepository repository;
  int _page = 1;

  SearchController(this.repository)
      : super(SearchState(photos: [], isLoading: false));

  Future<void> loadInitial() async {
    _page = 1;
    state = state.copyWith(isLoading: true);

    final photos = await repository.getPhotos(page: _page);

    state = SearchState(
      photos: photos,
      isLoading: false,
    );
  }

  Future<void> loadMore() async {
    if (state.isLoading) return;

    state = state.copyWith(isLoading: true);
    _page++;

    final newPhotos = await repository.getPhotos(page: _page);

    state = SearchState(
      photos: [...state.photos, ...newPhotos],
      isLoading: false,
    );
  }
}
