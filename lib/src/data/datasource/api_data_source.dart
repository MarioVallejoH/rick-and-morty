import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:rick_and_morty_app/src/domain/entities/request_data.dart';
import 'package:rick_and_morty_app/src/utils/utils/utils.dart';
import 'package:ua_client_hints/ua_client_hints.dart';

/// Class to perform API calls
class ApiDataSource {
  /// Api request constructor
  ApiDataSource() {
    _http.options.baseUrl =
        const String.fromEnvironment('HOST', defaultValue: '');
    _http.interceptors.add(EncodingInterceptor());
  }

  /// Headers
  static final Map<String, String> _headers = {};

  final _http = Dio();
  final _logger = GlobalLocator.appLogger;

  /// Method to check internet connection and set headers
  Future<void> _requestData({
    bool formData = false,
  }) async {
    if (formData) {
      _headers['Content-type'] = 'multipart/form-data';
    } else {
      _headers['Content-type'] = 'application/json';
    }
    _headers['Accept'] = '*/*';

    _headers['X-Platform'] = Platform.isIOS ? 'ios' : 'android';
    _headers['User-Agent'] = await userAgent();
    _http.options.headers = _headers;
  }

  Future<dynamic> _httpRequest(
    Future<dynamic> Function() request,
  ) async {
    return await request.call().timeout(
          const Duration(seconds: 30),
        );
  }

  static Map<String, dynamic> _resolveInternalError(dynamic e) {
    return {
      'success': false,
      'message': 'Internal error: \n $e',
      'error': true,
      'data': [],
    };
  }

  static Map<String, dynamic> _resolveServerErrorCode(DioException e) {
    return {
      'message': '${e.response?.data['message'] ?? e.message}',
      'error': true,
      'data': {},
    };
  }

  /// Perform any http-https request with a given [RequestData]
  Future<Map<String, dynamic>> request({
    required RequestData requestData,
    bool withAuthToken = true,
    dynamic Function(Object?)? fromJsonT,
  }) async {
    if (await isNetworkAvailable()) {
      /// Show toast with no internet connection message
    } else {
      toast('No internet connection');
      return {
        'error': true,
        'message': 'No internet connection',
        'data': [],
      };
    }
    await _requestData();
    _logger.d('Request endpoint: ${requestData.body}');
    _headers.addAll(requestData.headers);
    dynamic data;
    try {
      switch (requestData.method) {
        case Method.get:
          data = await get(
            requestData.path,
            queryParameters: requestData.queryParameters,
          );
          break;
        case Method.post:
          data = await post(
            requestData.path,
            requestData.body,
            queryParameters: requestData.queryParameters,
          );
          break;
        default:
          return {
            'error': true,
            'message': 'HTTP method not found.',
            'data': [],
          };
      }
    } on DioException catch (e) {
      data = _resolveServerErrorCode(e);
    } on Exception catch (e) {
      data = _resolveInternalError(e);
    }
    return data;
  }

  /// Perform API GET operations
  Future<dynamic> get(
    String endpoint, {
    bool withAuthToken = true,
    Map<String, dynamic>? queryParameters,
  }) async {
    return await _httpRequest(
      () async {
        try {
          _logger.d(
            'get() to ($endpoint) - headers ($_headers) to ${_http.options.baseUrl}${_http.options.baseUrl}',
          );

          final response = await _http.get(
            endpoint,
            queryParameters: queryParameters,
          );
          return response.data;
        } on DioException catch (e) {
          _logger.e(e.requestOptions.path);
          rethrow;
        } on Exception catch (e) {
          return _resolveInternalError(e);
        }
      },
    );
  }

  /// Perform API POST operations
  Future<dynamic> post(
    String endpoint,
    Map<String, dynamic> data, {
    Map<String, dynamic>? queryParameters,
  }) async {
    return await _httpRequest(
      () async {
        try {
          /// Used for test purposes
          _logger
              .d('post() to ($endpoint) - headers ($_headers) with data $data');
          final response = await _http.post(
            endpoint,
            data: data,
            queryParameters: queryParameters,
          );
          return response.data;
        } on DioException {
          rethrow;
        } on Exception catch (e) {
          return _resolveInternalError(e);
        }
      },
    );
  }
}

/// Dio Encoding interceptor
class EncodingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (options.queryParameters.isEmpty) {
      super.onRequest(options, handler);
      return;
    }

    final queryParams = _getQueryParams(options.queryParameters);
    handler.next(
      options.copyWith(
        path: _getNormalizedUrl(options.path, queryParams),
        queryParameters: Map.from({}),
      ),
    );
  }

  String _getNormalizedUrl(String baseUrl, String queryParams) {
    if (baseUrl.contains('?')) {
      return '$baseUrl&$queryParams';
    } else {
      return '$baseUrl?$queryParams';
    }
  }

  String _getQueryParams(Map<String, dynamic> map) {
    String result = '';
    map.forEach((key, value) {
      result += '$key=$value&';
    });
    return result;
  }
}

/// ApiDataSource instance
final dataSourceProvider =
    StateProvider<ApiDataSource>((ref) => ApiDataSource());
