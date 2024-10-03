import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:test_app/Model/user_models.dart';
import 'package:test_app/config/constant.dart';

class SignUpServices {
  Future<UserModel?> signup({
    required String name,
    required String username,
    required String email,
    required String password,
    String? photo,
  }) async {
    try {
      var data = {
        "name": name,
        "username": username,
        "email": email,
        "password": password,
        if (photo != null) "photo": photo,
      };

      final response = await http.post(
        Uri.parse('$kEndpoint/api/user/signup'),
        body: jsonEncode(data),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final responseBody = response.body;
        final json = jsonDecode(responseBody);
        if (json != null && json is Map<String, dynamic>) {
          var userData = json; // Assuming user data is at the root level
          if (userData != null && userData is Map<String, dynamic>) {
            return UserModel.fromJson(userData);
          } else {
            throw Exception("Invalid user data: $userData");
          }
        } else {
          throw Exception("Invalid response format");
        }
      } else {
        final responseBody = response.body;
        final json = jsonDecode(responseBody);
        throw json["error"];
      }
    } catch (error) {
      throw error.toString();
    }
  }
}
