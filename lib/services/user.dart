import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import '../Model/user_models.dart';
import '../config/constant.dart';

class UserServices {
  final box = GetStorage();

  Future<UserModel> login({
    String? username,
    String? email,
    required String password,
  }) async {
    var data = {
      if (username != null) "username": username,
      if (email != null) "email": email,
      "password": password,
    };

    var response = await http.post(
      Uri.parse("$kEndpoint/api/user/login"),
      body: jsonEncode(data),
      headers: {HttpHeaders.contentTypeHeader: "application/json"},
    );

    log('Response status: ${response.statusCode}');
    log('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final responseBody = response.body;
      if (responseBody.isNotEmpty) {
        final json = jsonDecode(responseBody);
        if (json != null && json is Map<String, dynamic>) {
          var userData = json; // Assuming user data is at the root level
          if (userData != null && userData is Map<String, dynamic>) {
            UserModel user = UserModel.fromJson(userData);
            await saveUser(user);
            return user;
          } else {
            throw Exception("Invalid user data: $userData");
          }
        } else {
          throw Exception("Invalid response format");
        }
      } else {
        throw Exception("Empty response body");
      }
    } else {
      final responseBody = response.body;
      if (responseBody.isNotEmpty) {
        final json = jsonDecode(responseBody);
        throw Exception(json["error"]);
      } else {
        throw Exception("Failed to login. Status code: ${response.statusCode}");
      }
    }
  }

   Future<UserModel> signup({
    required String name,
    required String username,
    required String email,
    required String password,
    String? photo,
  }) async {
    var data = {
      "name": name,
      "username": username,
      "email": email,
      "password": password,
      if (photo != null) "photo": photo,
    };

    var response = await http.post(
      Uri.parse("$kEndpoint/api/user/signup"),
      body: jsonEncode(data),
      headers: {HttpHeaders.contentTypeHeader: "application/json"},
    );

    log('Response status: ${response.statusCode}');
    log('Response body: ${response.body}');

    if (response.statusCode == 201) {
      final responseBody = response.body;
      if (responseBody.isNotEmpty) {
        final json = jsonDecode(responseBody);
        if (json != null && json is Map<String, dynamic>) {
          var userData = json; // Assuming user data is at the root level
          if (userData != null && userData is Map<String, dynamic>) {
            UserModel user = UserModel.fromJson(userData);
            await saveUser(user);
            return user;
          } else {
            throw Exception("Invalid user data: $userData");
          }
        } else {
          throw Exception("Invalid response format");
        }
      } else {
        throw Exception("Empty response body");
      }
    } else {
      final responseBody = response.body;
      if (responseBody.isNotEmpty) {
        final json = jsonDecode(responseBody);
        throw Exception(json["error"]);
      } else {
        throw Exception("Failed to signup. Status code: ${response.statusCode}");
      }
    }
  }

  Future<void> saveUser(UserModel user) async {
    box.remove(kUserInfo);
    box.write(kUserInfo, user.toJson());
  }
}
