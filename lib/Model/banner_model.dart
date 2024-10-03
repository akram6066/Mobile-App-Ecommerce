class BannerModel {
  final String id;
  final String name;
  final String description;
  final List<String> images;

  BannerModel({
    required this.id,
    required this.name,
    required this.description,
    required this.images,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      id: json['_id'],
      name: json['name'],
      description: json['description'],
      images: List<String>.from(json['images']),
    );
  }
}
