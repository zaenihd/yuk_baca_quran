import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart'; // Untuk kDebugMode
import 'api_exceptions.dart';

class DioClient {
  // Singleton pattern agar instance Dio hanya satu
  static final DioClient _instance = DioClient._internal();
  late final Dio _dio;

  factory DioClient() => _instance;

  DioClient._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: "https://equran.id/api/v2", // Ganti dengan Base URL kamu
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    // Menambahkan Interceptor untuk Logging & Auth Token (Opsional)
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          if (kDebugMode) {
            print('🌐 [REQUEST] ${options.method} ${options.path}');
            print('📦 [BODY] ${options.data}');
          }
          // Di sini bisa inject token: options.headers['Authorization'] = 'Bearer $token';
          return handler.next(options);
        },
        onResponse: (response, handler) {
          if (kDebugMode) {
            print('✅ [RESPONSE] ${response.statusCode} : ${response.data}');
          }
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          if (kDebugMode) {
            print('❌ [ERROR] ${e.response?.statusCode} : ${e.message}');
          }
          return handler.next(e);
        },
      ),
    );
  }

  // --- GET ---
  Future<dynamic> get(String path, {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.get(path, queryParameters: queryParameters);
      return response.data;
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  // --- POST (Support JSON & FormData) ---
  Future<dynamic> post(String path, {dynamic data, bool isFormData = false}) async {
    try {
      final response = await _dio.post(
        path, 
        data: isFormData ? FormData.fromMap(data) : data,
      );
      return response.data;
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  // --- PUT ---
  Future<dynamic> put(String path, {dynamic data}) async {
    try {
      final response = await _dio.put(path, data: data);
      return response.data;
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  // --- DELETE ---
  Future<dynamic> delete(String path, {dynamic data}) async {
    try {
      final response = await _dio.delete(path, data: data);
      return response.data;
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  // --- UPLOAD FILE (Helper khusus) ---
  Future<dynamic> uploadFile(String path, File file, {String fieldName = 'file'}) async {
    try {
      String fileName = file.path.split('/').last;
      FormData formData = FormData.fromMap({
        fieldName: await MultipartFile.fromFile(file.path, filename: fileName),
      });

      final response = await _dio.post(path, data: formData);
      return response.data;
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }
}