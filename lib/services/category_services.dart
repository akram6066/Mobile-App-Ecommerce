import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:test_app/Model/category_model.dart';
import 'package:test_app/config/constant.dart';


class CategoryService {
  Future<List<CategoryModel>> getCategoryData() async {
    final response = await http.get(Uri.parse('$kEndpoint/api/categories'));

    if (response.statusCode == 200) {
      List<CategoryModel> categories = (jsonDecode(response.body) as List)
          .map((category) => CategoryModel.fromJson(category))
          .toList();
      return categories;
    } else {
      throw Exception('Failed to load categories');
    }
  }
}