// order_provider.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:test_app/Model/orders_model.dart';
import 'package:test_app/config/constant.dart';

class OrderProvider with ChangeNotifier {
  List<OrderModel> _orders = [];

  List<OrderModel> get orders => _orders;

  Future<void> addOrder(Map<String, dynamic> orderData, String userId) async {
    const url = '$kEndpoint/api/orders';
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(orderData),
      );

      if (response.statusCode == 201) {
        final order = OrderModel.fromJson(json.decode(response.body));
        _orders.add(order);
        notifyListeners();
      } else {
        final responseBody = response.body;
        try {
          final errorData = json.decode(responseBody);
          throw Exception('Failed to place order: ${errorData['message']}');
        } catch (e) {
          throw Exception('Failed to place order: $responseBody');
        }
      }
    } catch (error) {
      throw Exception('Failed to place order: $error');
    }
  }

  Future<void> fetchOrdersByUserId(String userId) async {
    final url = '$kEndpoint/api/orders/user/$userId';
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> orderList = json.decode(response.body);
        _orders = orderList.map((order) => OrderModel.fromJson(order)).toList();
        notifyListeners();
      } else {
        final responseBody = response.body;
        try {
          final errorData = json.decode(responseBody);
          throw Exception('Failed to fetch orders: ${errorData['message']}');
        } catch (e) {
          throw Exception('Failed to fetch orders: $responseBody');
        }
      }
    } catch (error) {
      throw Exception('Failed to fetch orders: $error');
    }
  }
}
