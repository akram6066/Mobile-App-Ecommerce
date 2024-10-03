import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:test_app/Model/product_model.dart';
import 'package:test_app/config/constant.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _products = [];
  List<Product> get products => _products;

  bool _isTrendingLoaded = false;
  bool get isTrendingLoaded => _isTrendingLoaded;

  final Map<String, List<Product>> _similarProductsCache = {};
  final Map<String, List<Product>> _productsCache = {};

  List<Product> _trendingProducts = [];
  List<Product> get trendingProducts => _trendingProducts;
  List<Product> getProducts() {
  return _products;
}

 Future<void> fetchProductsByCategory(String categoryId) async {
  products.clear(); // Clear the products list
  notifyListeners();

  if (_productsCache.containsKey(categoryId)) {
    _products = _productsCache[categoryId]!; // Get products from cache
    notifyListeners();

    // Clear the products list again to prepare for fetching new products
    products.clear();
    notifyListeners();
  }

  final url = Uri.parse('$kEndpoint/api/products/category/$categoryId');
  try {
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> extractedData = json.decode(response.body);
      _products = extractedData.map((data) => Product.fromJson(data)).toList();
      _productsCache[categoryId] = _products; // Cache the fetched products
      notifyListeners(); // Notify listeners that new products have been fetched
    } else {
      throw Exception('Failed to load products');
    }
  } catch (error) {
    throw error;
  }
}



  // Future<void> fetchProductsByCategory(String categoryId) async {
  //   // Clear the current products when fetching new category
  //   _products.clear();
  //   notifyListeners();

  //   if (_productsCache.containsKey(categoryId)) {
  //     _products = _productsCache[categoryId]!;
  //     notifyListeners();
  //     return;
  //   }

  //   final url = Uri.parse('$kEndpoint/api/products/category/$categoryId');
  //   try {
  //     final response = await http.get(url);
  //     if (response.statusCode == 200) {
  //       final List<dynamic> extractedData = json.decode(response.body);
  //       _products =
  //           extractedData.map((data) => Product.fromJson(data)).toList();
  //       _productsCache[categoryId] = _products;
  //       notifyListeners();
  //     } else {
  //       throw Exception('Failed to load products');
  //     }
  //   } catch (error) {
  //     rethrow;
  //   }
  // }

  Future<List<Product>> fetchSimilarProducts(String categoryId) async {
    if (_similarProductsCache.containsKey(categoryId)) {
      return _similarProductsCache[categoryId]!;
    }

    final url = Uri.parse('$kEndpoint/api/products/category/$categoryId');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> extractedData = json.decode(response.body);
        final similarProducts =
            extractedData.map((data) => Product.fromJson(data)).toList();
        _similarProductsCache[categoryId] = similarProducts;
        return similarProducts;
      } else {
        throw Exception('Failed to load similar products');
      }
    } catch (error) {
      throw error;
    }
  }

  Future<void> fetchTrendingProducts() async {
    if (_isTrendingLoaded) return;

    final url = Uri.parse('$kEndpoint/api/products/trending');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> extractedData = json.decode(response.body);
        _trendingProducts =
            extractedData.map((data) => Product.fromJson(data)).toList();
        _isTrendingLoaded = true;
        notifyListeners();
      } else {
        throw Exception('Failed to load trending products');
      }
    } catch (error) {
      rethrow;
    }
  }

  void clearProducts() {
    for (var product in _products) {
      product.clear();
    }
    notifyListeners();
  }
}
