class CategoryModel {
  String? id;
  String? name;
  String? description;
  List<String>? photos;
  int? v;

  CategoryModel({
    this.id,
    this.name,
    this.description,
    this.photos,
    this.v,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        id: json["_id"],
        name: json["name"],
        description: json["description"],
        photos: json["photos"] == null ? [] : List<String>.from(json["photos"].map((x) => x)),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "description": description,
        "photos": photos == null ? [] : List<dynamic>.from(photos!.map((x) => x)),
        "__v": v,
      };
}
