import 'dart:convert';
import 'package:http/http.dart' as http;
import '../features/homeDashboard/datamodels/firstSliderDataModel.dart';

class ApiController{
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
}