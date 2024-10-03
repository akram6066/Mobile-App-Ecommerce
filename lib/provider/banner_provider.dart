import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart'; // Import get_storage
import 'package:test_app/model/banner_model.dart';
import 'package:test_app/config/constant.dart';

class BannerProvider with ChangeNotifier {
  List<BannerModel> _banners = [];
  bool _isDataLoaded = false; // Track if data has been loaded
  int _currentIndex = 0;

  List<BannerModel> get banners => _banners;
  bool get isDataLoaded => _isDataLoaded;
  int get currentIndex => _currentIndex;

  final _storage = GetStorage(); // Initialize get_storage

  Future<void> fetchBanners() async {
    if (_isDataLoaded) {
      // If data is already loaded, skip loading process
      return;
    }

    try {
      final cachedData = _storage.read('banners');
      if (cachedData != null) {
        // If cached data exists, use it without fetching from network
        _banners = (json.decode(cachedData) as List)
            .map((item) => BannerModel.fromJson(item))
            .toList();
      } else {
        final response = await http.get(Uri.parse('$kEndpoint/api/banners'));
        if (response.statusCode == 200) {
          final List<dynamic> data = json.decode(response.body);
          _banners = data.map((item) => BannerModel.fromJson(item)).toList();
          // Cache the fetched data using get_storage
          _storage.write('banners', json.encode(data));
        } else {
          throw Exception('Failed to load banners');
        }
      }
      _isDataLoaded = true; // Mark data as loaded
    } catch (error) {
      rethrow;
    } finally {
      notifyListeners();
    }
  }

  void setCurrentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}
