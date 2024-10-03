
// import 'dart:convert';
// import 'package:flutter/cupertino.dart';
// import 'package:http/http.dart' as http;
// import 'package:test_app/Model/product_model.dart';
// // Ensure this path is correct for your project
// import '../config/constant.dart';

// class SearchProvider extends ChangeNotifier {
//   static const apiEndpoint = '$kEndpoint/api/products/search';

//   bool isLoading = true;
//   String error = '';
//   List<Product> products = [];
//   List<Product> searchedProducts = [];
//   String searchText = '';

//   // Fetch data from API
//   getDataFromAPI() async {
//     try {
//       final response = await http.get(Uri.parse(apiEndpoint));
//       if (response.statusCode == 200) {
//         products = productFromJson(response.body);
//       } else {
//         error = 'Error: ${response.statusCode}';
//       }
//     } catch (e) {
//       error = 'Error: $e';
//     }
//     isLoading = false;
//     updateData();
//   }

//   // Update data based on search text
//   updateData() {
//     searchedProducts.clear();
//     if (searchText.isEmpty) {
//       searchedProducts.addAll(products);
//     } else {
//       searchedProducts.addAll(products.where((product) =>
//           product.name.toLowerCase().contains(searchText.toLowerCase())));
//     }
//     notifyListeners();
//   }

//   // Search function
//   search(String query) {
//     searchText = query;
//     updateData();
//   }
// }

// // Function to convert JSON string to a list of Product objects
// List<Product> productFromJson(String str) {
//   final jsonData = json.decode(str);
//   return List<Product>.from(jsonData.map((x) => Product.fromJson(x)));
// }
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:test_app/Model/product_model.dart';

import '../config/constant.dart';

class SearchProvider extends ChangeNotifier {
  static const apiEndpoint = '$kEndpoint/api/products/search';

  bool isLoading = true;
  String error = '';
  List<Product> products = [];
  List<Product> searchedProducts = [];
  String searchText = '';

  // Fetch data from API
  getDataFromAPI() async {
    try {
      final response = await http.get(Uri.parse(apiEndpoint));
      if (response.statusCode == 200) {
        products = productFromJson(response.body);
        updateData();
      } else {
        error = 'Error: ${response.statusCode}';
      }
    } catch (e) {
      error = 'Error: $e';
    }
    isLoading = false;
    notifyListeners();
  }

  // Update data based on search text
  updateData() {
    searchedProducts.clear();
    if (searchText.isEmpty) {
      searchedProducts = [];
    } else {
      searchedProducts.addAll(products.where((product) =>
          product.name!.toLowerCase().contains(searchText.toLowerCase())));
    }
    notifyListeners();
  }

  // Search function
  search(String query) {
    searchText = query;
    updateData();
  }
}

// Ensure this path is correct for your project
List<Product> productFromJson(String str) {
  final jsonData = json.decode(str);
  return List<Product>.from(jsonData.map((x) => Product.fromJson(x)));
}
