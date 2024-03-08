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
  }) async {
    Map<String, dynamic> queryParams = {
      'latitude': latitude.toString(),
      'longitude': longitude.toString(),
      'method': '1', // Fixed value
      'school': school.toString(),
    };

    // Construct the full endpoint URL with query parameters
    String fullUrl = _httpService.buildUrl("${EndPoints.PRAYER_TIMINGS}$date", queryParams);
    log(fullUrl);
    return await _httpService.get(fullUrl);
  }

  Future<dynamic> createPost(dynamic postData) async {
    return await _httpService.post('/posts', postData);
  }

  Future<dynamic> updatePost(int postId, dynamic updatedData) async {
    return await _httpService.put('/posts/$postId', updatedData);
  }

  Future<dynamic> deletePost(int postId) async {
    return await _httpService.delete('/posts/$postId');
  }
}
