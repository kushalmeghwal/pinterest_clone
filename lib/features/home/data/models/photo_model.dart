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
      id: json['id'] ?? 0,
      imageUrl: json['src']['medium'] ?? "",
      photographer: json['photographer'] ?? "",
    );
  }
}

// The following assertion was thrown during performLayout():
// BoxConstraints has a negative minimum width.
//Another exception was thrown: Null check operator used on a null value