import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'exception.dart';
import 'logger.dart';

class DioClient {
  final Dio _dio;

  DioClient(this._dio) {
    _setupSSL();
  }

  void _setupSSL() async {
    final sslCert = await rootBundle.load('assets/certificates/themoviedb.pem');
    SecurityContext context = SecurityContext(withTrustedRoots: false);
    context.setTrustedCertificatesBytes(sslCert.buffer.asUint8List());

    (_dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
      final client = HttpClient(context: context);
      client.badCertificateCallback = (cert, host, port) =>
          false; // reject untrusted
      return client;
    };
  }

  Response<Object> checkStatus(DioException e) {
    LoggerUtils.loggerError("DioException: ${e.message}");
    LoggerUtils.loggerError("DioException Type: ${e.type}");
    LoggerUtils.loggerError("DioException Response: ${e.response?.data}");

    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout ||
        e.type == DioExceptionType.sendTimeout ||
        e.type == DioExceptionType.connectionError) {
      throw const ApiException(
        message: "Koneksi gagal, periksa jaringan Anda.",
      );
    }

    if (e.type == DioExceptionType.badResponse) {
      final response = e.response;
      if (response != null && response.data is Map<String, dynamic>) {
        final data = response.data as Map<String, dynamic>;
        final message =
            data['status_message'] ?? "Terjadi kesalahan dari server.";
        throw ApiException(message: message);
      } else {
        throw const ApiException(message: "Respon tidak valid dari server.");
      }
    }

    throw ApiException(message: e.message ?? "Terjadi kesalahan tak terduga.");
  }

  Future<Response> get(
    String uri, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
    String token = "",
  }) async {
    final dioOptions = await generateDioOption(options, endPoint: uri);
    LoggerUtils.loggerRequest("GET", uri, queryParameters.toString());
    try {
      final response = await _dio
          .get(
            uri,
            queryParameters: queryParameters,
            options: dioOptions,
            cancelToken: cancelToken,
            onReceiveProgress: onReceiveProgress,
          )
          .timeout(const Duration(seconds: 15));
      LoggerUtils.loggerResponse(response.data);
      return response;
    } on DioException catch (e) {
      checkStatus(e);
      rethrow;
    }
  }

  // Fungsi POST, PUT, PATCH, DELETE tetap sama seperti sebelumnya...
  // Tinggal hapus bagian createHttpClient dari masing-masing dan hanya perlu di setup sekali di constructor
  // via _setupSSL().

  // Delete:-----------------------------------------------------------------------
  Future<Response> delete(
    String uri, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    bool useToken = true,
    CancelToken? cancelToken,
  }) async {
    final dioOptions = await generateDioOption(options, endPoint: uri);
    LoggerUtils.loggerRequest("DELETE", uri, queryParameters.toString());
    try {
      final response = await _dio
          .delete(
            uri,
            queryParameters: queryParameters,
            options: dioOptions,
            cancelToken: cancelToken,
          )
          .timeout(const Duration(seconds: 15));
      LoggerUtils.loggerResponse(response.data);
      return response;
    } on DioException catch (e) {
      checkStatus(e);
      LoggerUtils.loggerError(
        e.response?.data.toString() ?? e.response.toString(),
      );
      rethrow;
    }
  }

  // Post:----------------------------------------------------------------------
  Future<Response> post(
    String uri, {
    bool useToken = true,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    Options? dioOptions;
    if (useToken) {
      dioOptions = await generateDioOption(options, endPoint: uri);
    }
    LoggerUtils.loggerRequest(
      "POST",
      uri,
      queryParameters.toString(),
      data.toString(),
    );
    try {
      final response = await _dio
          .post(
            uri,
            data: data,
            queryParameters: queryParameters,
            options: dioOptions,
            cancelToken: cancelToken,
            onSendProgress: onSendProgress,
            onReceiveProgress: onReceiveProgress,
          )
          .timeout(const Duration(seconds: 15));
      LoggerUtils.loggerError("status code ${response.statusCode.toString()}");
      LoggerUtils.loggerError("response ${response.toString()}");
      LoggerUtils.loggerError('data ${response.data.toString()}');
      LoggerUtils.loggerResponse(response.data);
      return response;
    } on DioException catch (e) {
      checkStatus(e);
      LoggerUtils.loggerError(
        e.response?.data.toString() ?? e.response.toString(),
      );
      rethrow;
    }
  }

  Future<Response> put(
    String uri, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    bool useToken = true,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final dioOptions = await generateDioOption(options, endPoint: uri);
    LoggerUtils.loggerRequest(
      "PUT",
      uri,
      queryParameters.toString(),
      data.toString(),
    );
    try {
      final response = await _dio
          .put(
            uri,
            data: data,
            queryParameters: queryParameters,
            options: dioOptions,
            cancelToken: cancelToken,
            onSendProgress: onSendProgress,
            onReceiveProgress: onReceiveProgress,
          )
          .timeout(const Duration(seconds: 15));
      LoggerUtils.loggerResponse(response.data);
      return response;
    } on DioException catch (e) {
      checkStatus(e);
      LoggerUtils.loggerError(
        e.response?.data.toString() ?? e.response.toString(),
      );
      rethrow;
    }
  }

  Future<Response> patch(
    String uri, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final dioOptions = await generateDioOption(options, endPoint: uri);
    LoggerUtils.loggerRequest(
      "PUT",
      uri,
      queryParameters.toString(),
      data.toString(),
    );
    try {
      final response = await _dio
          .patch(
            uri,
            data: data,
            queryParameters: queryParameters,
            options: dioOptions,
            cancelToken: cancelToken,
            onSendProgress: onSendProgress,
            onReceiveProgress: onReceiveProgress,
          )
          .timeout(const Duration(seconds: 15));
      LoggerUtils.loggerResponse(response.data);
      return response;
    } on DioException catch (e) {
      checkStatus(e);
      LoggerUtils.loggerError(
        e.response?.data.toString() ?? e.response.toString(),
      );
      rethrow;
    }
  }

  Future<Options> generateDioOption(
    Options? options, {
    required String endPoint,
    String token = "",
  }) async {
    final dioOptions = options ?? Options();
    dioOptions.headers = dioOptions.headers ?? {};
    dioOptions.headers!["content-type"] = "application/json";
    return dioOptions;
  }
}
