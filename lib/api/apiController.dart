import 'dart:convert';
import 'package:http/http.dart' as http;
import '../features/brands/datamodels/BrandsDataModel.dart';
import '../features/homeDashboard/datamodels/CouponResponseDataModel.dart';
import '../features/homeDashboard/datamodels/HomepageDataModel.dart';
import '../features/homeDashboard/datamodels/firstSliderDataModel.dart';
import '../features/offers/datamodels/offersDataModel.dart';

class ApiController {
  static const String _baseUrl = 'https://www.discountzshop.com/api';

  Future<FirstSliderResponseDataModel> fetchFirstSliders() async {
    try {
      final response = await http.get(Uri.parse("$_baseUrl/home-sliders"));

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return FirstSliderResponseDataModel.fromJson(jsonData);
      } else {
        throw Exception('Failed to load sliders: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching sliders: $e');
    }
  }

  Future<CouponResponse> getCoupons() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/coupons-all'));
      // print(json.decode(response.statusCode.toString()));
      // print(json.decode(response.body));
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        // print(jsonData);
        return CouponResponse.fromJson(jsonData);
      } else {
        throw Exception('Failed to load coupons: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching coupons: $e');
    }
  }

  Future<HomepageResponse> getHomepage() async {
    try {
      // print('Making API call to $_baseUrl/homepage');
      final response = await http.get(Uri.parse('$_baseUrl/homepage'));

      // print('Homepage API Status Code: ${response.statusCode}');
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        // print('Homepage API Response Body: $jsonData');
        return HomepageResponse.fromJson(jsonData);
      } else {
        throw Exception('Failed to load homepage data: ${response.statusCode}');
      }
    } catch (e) {
      print('Homepage API Error: $e');
      throw Exception('Error fetching homepage data: $e');
    }
  }

  Future<List<Offer>> fetchOffers({int page = 1, int limit = 10}) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/offers-all?paginate=$limit&page=$page'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        if (jsonData['status'] == 'success') {
          return (jsonData['data'] as List)
              .map((offer) => Offer.fromJson(offer))
              .toList();
        } else {
          throw Exception('API returned unsuccessful status');
        }
      } else {
        throw Exception('Failed to load offers: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching offers: $e');
    }
  }

  Future<List<Brand>> fetchBrands({int page = 1, int limit = 10}) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/brands-all?per_page=$limit&page=$page'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        if (jsonData['status'] == 'success') {
          return (jsonData['data']['data'] as List)
              .map((brand) => Brand.fromJson(brand))
              .toList();
        } else {
          throw Exception('API returned unsuccessful status');
        }
      } else {
        throw Exception('Failed to load brands: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching brands: $e');
    }
  }
}
