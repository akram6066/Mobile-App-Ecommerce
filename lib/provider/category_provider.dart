import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:test_app/config/constant.dart';
import 'package:http/http.dart' as http;
import '../Model/category_model.dart';

class CategoryProvider with ChangeNotifier {
  List<CategoryModel> _categories = [];
  bool _categoriesLoaded = false;

  List<CategoryModel> get categories => _categories;
  bool get categoriesLoaded => _categoriesLoaded;

  Future<void> loadCategories() async {
    if (!_categoriesLoaded) {
      final response = await http.get(Uri.parse("$kEndpoint/api/categories"));
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        _categories = data.map((json) => CategoryModel.fromJson(json)).toList();
        _categoriesLoaded = true; // Mark categories as loaded
        notifyListeners();
      } else {
        throw Exception('Failed to load categories');
      }
    }
  }
}
