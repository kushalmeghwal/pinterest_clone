class PhotoModel {
  final int id;
  final String imageUrl;
  final String photographer;
  PhotoModel({
    required this.id,
    required this.imageUrl,
    required this.photographer,
  });
  factory PhotoModel.fromJson(Map<String, dynamic> json) {
    return PhotoModel(
      id: json['id'],
      imageUrl: json['src']['medium'],
      photographer: json['photographer'] ?? "",
    );
  }
}
