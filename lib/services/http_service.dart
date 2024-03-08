import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:prayer_pro/prayer_model.dart';

import 'logging_interceptor.dart';

class HttpService {
  static const String baseUrl = 'http://api.aladhan.com/v1'; // Replace with your API base URL

  final Dio _dio = Dio();

  HttpService() {
    _dio.interceptors.add(LoggingInterceptor());
  }

  Future<dynamic> get(String fullUrl) async {
    try {
      final response = await _dio.get(fullUrl);
      return _handleResponse(response);
    } catch (e) {
      throw Exception('Failed to load data: $e');
    }
  }

  Future<dynamic> post(String path, dynamic body) async {
    try {
      final response = await _dio.post('$baseUrl$path', data: body);
      return _handleResponse(response);
    } catch (e) {
      throw Exception('Failed to load data: $e');
    }
  }

  Future<dynamic> put(String path, dynamic body) async {
    try {
      final response = await _dio.put('$baseUrl$path', data: body);
      return _handleResponse(response);
    } catch (e) {
      throw Exception('Failed to load data: $e');
    }
  }

  Future<dynamic> delete(String path) async {
    try {
      final response = await _dio.delete('$baseUrl$path');
      return _handleResponse(response);
    } catch (e) {
      throw Exception('Failed to load data: $e');
    }
  }

  dynamic _handleResponse(Response response) {
    if (response.statusCode! >= 200 && response.statusCode! < 300) {
      print('${prayerModelFromJson(response.data)}');
      return response.data;
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }

  String buildUrl(String endpoint, Map<String, dynamic> queryParams) {
    String queryString = '';

    // Build the query string with parameters
    queryParams.forEach((key, value) {
      if (queryString.isNotEmpty) {
        queryString += '&';
      }
      queryString += '$key=$value';
    });

    // Append the query string to the endpoint
    String fullUrl = '$baseUrl$endpoint?$queryString';

    return fullUrl;
  }

}
