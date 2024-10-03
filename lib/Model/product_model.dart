
// class Product {
//   final String id;
//  final String name;
//   final String description;
//   final List<String> images;
//   final double price;
//   final double salePrice;
//   final DateTime salePriceDate;
//   final bool isTrending;
//   final int units;
//   final String catID;

//   Product({
//     required this.id,
//     required this.name,
//     required this.description,
//     required this.images,
//     required this.price,
//     required this.salePrice,
//     required this.salePriceDate,
//     required this.isTrending,
//     required this.units,
//     required this.catID,
//   });

//   factory Product.fromJson(Map<String, dynamic> json) {
//     return Product(
//       id: json['_id'],
//       name: json['name'],
//       description: json['description'],
//       images: List<String>.from(json['images']),
//       price: json['price'].toDouble(),
//       salePrice: json['salePrice'] != null ? json['salePrice'].toDouble() : 0.0,
//       salePriceDate: json['salePriceDate'] != null ? DateTime.parse(json['salePriceDate']) : DateTime.now(),
//       isTrending: json['isTrending'],
//       units: json['units'],
//       catID: json['catID'] is Map<String, dynamic> ? json['catID']['_id'] : json['catID'],
//     );
//   }


//     void clear() {
//     id = null;
//     name = null;
//     description = null;
//     price = null;
//     selprice = null;
//     selpriceDate = null;
//     category = null;
//     isTrending = false;
//     unit = 0;
//     rating = 0.0;
//     images?.clear();
//     isFavorite = false;
//     discountPercentage = 0.0;
//   }
// }
class Product {
  String? id;
  String? name;
  String? description;
  List<String> images;
  double? price;
  double? salePrice;
  DateTime? salePriceDate;
  bool isTrending;
  int units;
  String? catID;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.images,
    required this.price,
    required this.salePrice,
    required this.salePriceDate,
    required this.isTrending,
    required this.units,
    required this.catID,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['_id'],
      name: json['name'],
      description: json['description'],
      images: List<String>.from(json['images']),
      price: json['price'].toDouble(),
      salePrice: json['salePrice'] != null ? json['salePrice'].toDouble() : 0.0,
      salePriceDate: json['salePriceDate'] != null ? DateTime.parse(json['salePriceDate']) : DateTime.now(),
      isTrending: json['isTrending'],
      units: json['units'],
      catID: json['catID'] is Map<String, dynamic> ? json['catID']['_id'] : json['catID'],
    );
  }

  void clear() {
    id = null;
    name = null;
    description = null;
    price = null;
    salePrice = null;
    salePriceDate = null;
    isTrending = false;
    units = 0;
    catID = null;
    images.clear();
  }
}

