import 'dart:convert';

import 'package:test_app/Model/orders_model.dart';

List<UserModel> userModelFromJson(String str) => List<UserModel>.from(json.decode(str).map((x) => UserModel.fromJson(x)));

String userModelToJson(List<UserModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserModel {
  String? id;
  String? name;
  String? username;
  String? email;
  String? password;
  String? photo;
  String? userType;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  UserModel({
    this.id,
    this.name,
    this.username,
    this.email,
    this.password,
    this.photo,
    this.userType,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json["_id"],
    name: json["name"],
    username: json["username"],
    email: json["email"],
    password: json["password"],
    photo: json["photo"],
    userType: json["userType"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "username": username,
    "email": email,
    "password": password,
    "photo": photo,
    "userType": userType,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };

  //   User toUser() {
  //   return User(id: id, name: name, email: email);
  // }
}
