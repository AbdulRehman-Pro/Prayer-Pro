import 'dart:async';

import 'package:color_log/color_log.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

/// [LoggingInterceptor] is used to print logs during network requests.
/// It's better to add [LoggingInterceptor] to the tail of the interceptor queue,
/// otherwise the changes made in the interceptor behind A will not be printed out.
/// This is because the execution of interceptors is in the order of addition.

class LoggingInterceptor extends Interceptor {
  LoggingInterceptor();

  @override
  Future onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    clog.custom(
        ansiColor: "\x1B[33m",
        emoji: "🚀",
        logType: "on-Request",
        message: '*** API Request - Start ***');
    String bold = '\x1B[1m';
    String normal = '\x1B[0m';
    String reset = '\x1B[0m';
    String _pink = "\x1b[38;5;205m";
    print('$_pink$bold${options.uri}$normal$_pink');
    // printKV('URI', options.uri);
    printKV('METHOD', options.method);
    logPrint('HEADERS:');
    options.headers.forEach((key, v) => printKV(' - $key', v));
    logPrint('BODY:');
    printAll(options.data ?? '');

    clog.custom(
        ansiColor: "\x1B[33m",
        emoji: "🚀",
        logType: "on-Request",
        message: '*** API Request - End ***');

    return handler.next(options);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    clog.custom(
        ansiColor: "\x1B[31m",
        emoji: "⛔",
        logType: "ON-ERROR",
        message: '*** Api Error - Start ***:');

    logPrint('URI: ${err.requestOptions.uri}');
    if (err.response != null) {
      logPrint('STATUS CODE: ${err.response?.statusCode?.toString()}');
    }
    logPrint('$err');
    if (err.response != null) {
      printKV('REDIRECT', err.response?.realUri ?? '');
      logPrint('BODY:');
      printAll(err.response?.data.toString());
    }

    clog.custom(
        ansiColor: "\x1B[31m",
        emoji: "⛔",
        logType: "ON-ERROR",
        message: '*** Api Error - End ***:');

    return handler.next(err);
  }

  @override
  Future onResponse(
      Response response, ResponseInterceptorHandler handler) async {
    clog.custom(
        ansiColor: "\x1b[36m",
        emoji: "✅",
        logType: "ON-RESPONSE",
        message: '*** Api Response - Start ***');

    printKV('URI', response.requestOptions.uri);
    printKV('STATUS CODE', response.statusCode ?? '');
    printKV('REDIRECT', response.isRedirect ?? false);
    logPrint('BODY:');
    printAll(response.data ?? '');

    clog.custom(
        ansiColor: "\x1b[36m",
        emoji: "✅",
        logType: "ON-RESPONSE",
        message: '*** Api Response - End ***');

    return handler.next(response);
  }

  void printKV(String key, Object v) {
    logPrint('$key: $v');
  }

  void printAll(msg) {
    msg.toString().split('\n').forEach(logPrint);
  }

  void logPrint(String s) {
    debugPrint(s);
  }
}
