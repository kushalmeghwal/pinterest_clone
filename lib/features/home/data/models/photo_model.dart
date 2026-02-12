class PhotoModel {
  final int id;
  final String imageUrl;
  final String photographer;
  final int width;
  final int height;
  PhotoModel({
    required this.id,
    required this.imageUrl,
    required this.photographer,
    required this.width,
    required this.height,
  });
  factory PhotoModel.fromJson(Map<String, dynamic> json) {
    return PhotoModel(
      id: json['id'] ?? 0,
      imageUrl: json['src']['medium'] ?? "",
      photographer: json['photographer'] ?? "",
      width: json['width'] ?? 1,
      height: json['height'] ?? 1,
    );
  }
}

// The following assertion was thrown during performLayout():
// BoxConstraints has a negative minimum width.
//Another exception was thrown: Null check operator used on a null value
