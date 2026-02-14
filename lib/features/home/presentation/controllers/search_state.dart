

import 'package:pinterest_clone/features/home/data/models/photo_model.dart';

class SearchState {
  final List<PhotoModel> photos;
  final bool isLoading;

  SearchState({
    required this.photos,
    required this.isLoading,
  });

  SearchState copyWith({
    List<PhotoModel>? photos,
    bool? isLoading,
  }) {
    return SearchState(
      photos: photos ?? this.photos,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
