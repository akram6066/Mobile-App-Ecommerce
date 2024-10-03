// // To parse this JSON data, do
// //
// //     final orderModel = orderModelFromJson(jsonString);

// import 'dart:convert';

// List<OrderModel> orderModelFromJson(String str) =>
//     List<OrderModel>.from(json.decode(str).map((x) => OrderModel.fromJson(x)));

// String orderModelToJson(List<OrderModel> data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

// class OrderModel {
//   String? id;
//   User? user;
//   int? phone;
//   String? address;
//   List<OrderItem>? orderItems;
//   String? description;
//   int? paymentPhone;
//   int? totalprice;
//   int? deliverprice;
//   String? payment;
//   String? status;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//   int? v;

//   OrderModel({
//     this.id,
//     this.user,
//     this.phone,
//     this.address,
//     this.orderItems,
//     this.description,
//     this.paymentPhone,
//     this.totalprice,
//     this.deliverprice,
//     this.payment,
//     this.status,
//     this.createdAt,
//     this.updatedAt,
//     this.v,
//   });

//   factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
//         id: json["_id"],
//         user: json["user"] == null ? null : User.fromJson(json["user"]),
//         phone: json["phone"],
//         address: json["address"],
//         orderItems: json["orderItems"] == null
//             ? []
//             : List<OrderItem>.from(
//                 json["orderItems"]!.map((x) => OrderItem.fromJson(x))),
//         description: json["description"],
//         paymentPhone: json["paymentPhone"],
//         totalprice: json["totalprice"],
//         deliverprice: json["deliverprice"],
//         payment: json["payment"],
//         status: json["status"],
//         createdAt: json["createdAt"] == null
//             ? null
//             : DateTime.parse(json["createdAt"]),
//         updatedAt: json["updatedAt"] == null
//             ? null
//             : DateTime.parse(json["updatedAt"]),
//         v: json["__v"],
//       );

//   Map<String, dynamic> toJson() => {
//         "_id": id,
//         "user": user?.toJson(),
//         "phone": phone,
//         "address": address,
//         "orderItems": orderItems == null
//             ? []
//             : List<dynamic>.from(orderItems!.map((x) => x.toJson())),
//         "description": description,
//         "paymentPhone": paymentPhone,
//         "totalprice": totalprice,
//         "deliverprice": deliverprice,
//         "payment": payment,
//         "status": status,
//         "createdAt": createdAt?.toIso8601String(),
//         "updatedAt": updatedAt?.toIso8601String(),
//         "__v": v,
//       };
// }

// class OrderItem {
//   Product? product;
//   int? quantity;
//   String? id;

//   OrderItem({
//     this.product,
//     this.quantity,
//     this.id,
//   });

//   // factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
//   //     product: json["product"] == null ? null : Product.fromJson(json["product"]),
//   //     quantity: json["quantity"],
//   //     id: json["_id"],
//   // );
//   factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
//         product:
//             json["product"] == null ? null : Product.fromJson(json["product"]),
//         quantity: json["quantity"],
//         id: json["_id"],
//       );

//   Map<String, dynamic> toJson() => {
//         "product": product?.toJson(),
//         "quantity": quantity,
//         "_id": id,
//       };
// }

// class Product {
//   String? id;
//   String? name;
//   int? price;

//   Product({
//     this.id,
//     this.name,
//     this.price,
//   });

//   factory Product.fromJson(Map<String, dynamic> json) => Product(
//         id: json["_id"],
//         name: json["name"],
//         price: json["price"],
//       );

//   Map<String, dynamic> toJson() => {
//         "_id": id,
//         "name": name,
//         "price": price,
//       };
// }

// class User {
//   String? id;
//   String? name;
//   String? email;

//   User({
//     this.id,
//     this.name,
//     this.email,
//   });

//   factory User.fromJson(Map<String, dynamic> json) => User(
//         id: json["_id"],
//         name: json["name"],
//         email: json["email"],
//       );

//   Map<String, dynamic> toJson() => {
//         "_id": id,
//         "name": name,
//         "email": email,
//       };
// }
import 'dart:convert';

List<OrderModel> orderModelFromJson(String str) =>
    List<OrderModel>.from(json.decode(str).map((x) => OrderModel.fromJson(x)));

String orderModelToJson(List<OrderModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OrderModel {
  String? id;
  String? user; // Change to String to store user ID directly
  int? phone;
  String? address;
  List<OrderItem>? orderItems;
  String? description;
  int? paymentPhone;
  int? totalprice;
  int? deliverprice;
  String? payment; // Change to String to store payment ID directly
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  OrderModel({
    this.id,
    this.user,
    this.phone,
    this.address,
    this.orderItems,
    this.description,
    this.paymentPhone,
    this.totalprice,
    this.deliverprice,
    this.payment,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        id: json["_id"],
        user: json["user"],
        phone: json["phone"],
        address: json["address"],
        orderItems: json["orderItems"] == null
            ? []
            : List<OrderItem>.from(
                json["orderItems"]!.map((x) => OrderItem.fromJson(x))),
        description: json["description"],
        paymentPhone: json["paymentPhone"],
        totalprice: json["totalprice"],
        deliverprice: json["deliverprice"],
        payment: json["payment"],
        status: json["status"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "user": user,
        "phone": phone,
        "address": address,
        "orderItems": orderItems == null
            ? []
            : List<dynamic>.from(orderItems!.map((x) => x.toJson())),
        "description": description,
        "paymentPhone": paymentPhone,
        "totalprice": totalprice,
        "deliverprice": deliverprice,
        "payment": payment,
        "status": status,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}

class OrderItem {
  String? product; // Change to String to store product ID directly
  int? quantity;
  String? id;

  OrderItem({
    this.product,
    this.quantity,
    this.id,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
        product: json["product"],
        quantity: json["quantity"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "product": product,
        "quantity": quantity,
        "_id": id,
      };
}
