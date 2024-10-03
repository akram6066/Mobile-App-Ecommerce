import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:test_app/Model/product_model.dart';
import 'package:test_app/config/constant.dart';
import 'dart:convert';



class ProductSearchProvider extends ChangeNotifier {
  late List<Product> _products = [];
  bool _isLoading = false;

  List<Product> get products => _products;
  bool get isLoading => _isLoading;

  void searchByName(String keyword) {
    _isLoading = true;
    notifyListeners();

    // Assuming your API endpoint for searching products by name is "/products/search?name={keyword}"
    String apiUrl = "$kEndpoint/products/search?name=$keyword";

    http.get(Uri.parse(apiUrl)).then((response) {
      if (response.statusCode == 200) {
        Iterable list = json.decode(response.body);
        _products = list.map((model) => Product.fromJson(model)).toList();
        _isLoading = false;
        notifyListeners();
      } else {
        throw Exception('Failed to load products');
      }
    }).catchError((error) {
      _isLoading = false;
      notifyListeners();
      print(error);
    });
  }
}
