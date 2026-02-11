import 'package:pinterest_clone/features/home/data/models/photo_model.dart';

class HomeState {
  final List<PhotoModel> photos;
  final bool isLoading;
  HomeState({required this.photos, required this.isLoading});
  HomeState copyWith({List<PhotoModel>? photos, bool? isLoading}) {
    return HomeState(
      photos: photos ?? this.photos,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
