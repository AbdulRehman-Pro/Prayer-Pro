import 'dart:developer';

import 'package:prayer_pro/services/end_points.dart';

import 'http_service.dart';

class ApiService {
  final HttpService _httpService = HttpService();

  Future<dynamic> fetchPrayers({
    required String date,
    required double latitude,
    required double longitude,
    required int school,
    required int adjustment,
  }) async {
    Map<String, dynamic> queryParams = {
      'latitude': latitude.toString(),
      'longitude': longitude.toString(),
      'method': '1', // Fixed value
      'school': school.toString(),
      'adjustment': adjustment
    };

    // Construct the full endpoint URL with query parameters
    String fullUrl = _httpService.buildUrl("${EndPoints.PRAYER_TIMINGS}$date", queryParams);

    return await _httpService.get(fullUrl);
  }
}
