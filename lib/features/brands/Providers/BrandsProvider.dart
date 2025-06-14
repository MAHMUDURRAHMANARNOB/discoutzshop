import 'package:flutter/material.dart';

import '../../../api/apiController.dart';
import '../datamodels/BrandsDataModel.dart';

class BrandProvider with ChangeNotifier {
  final ApiController _apiController = ApiController();
  Map<String, List<Brand>> _brandsByCategory = {};
  bool _isLoading = false;
  bool _hasMore = true;
  int _currentPage = 1;
  String? _error;
  late Future<void> _initialFetch;

  Map<String, List<Brand>> get brandsByCategory => _brandsByCategory;
  bool get isLoading => _isLoading;
  bool get hasMore => _hasMore;
  String? get error => _error;
  Future<void> get initialFetch => _initialFetch;

  BrandProvider() {
    _initialFetch = _fetchBrands(refresh: true);
  }

  Future<void> _fetchBrands({bool refresh = false}) async {
    if (_isLoading || (!refresh && !_hasMore)) return;

    _isLoading = true;
    _error = null;
    if (refresh) {
      _currentPage = 1;
      _brandsByCategory.clear();
      _hasMore = true;
    }
    notifyListeners();

    try {
      final newBrands = await _apiController.fetchBrands(page: _currentPage);
      if (newBrands.isEmpty) {
        _hasMore = false;
      } else {
        for (var brand in newBrands) {
          final category = brand.categoryName;
          _brandsByCategory.putIfAbsent(category!, () => []).add(brand);
        }
        _currentPage++;
      }
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadMore() => _fetchBrands();
  Future<void> refresh() => _fetchBrands(refresh: true);
}