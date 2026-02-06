import 'package:dio/dio.dart';

class ApiException implements Exception {
  final String message;
  final int? statusCode;

  ApiException({required this.message, this.statusCode});

  @override
  String toString() => message;

  // Helper untuk mengubah DioException menjadi ApiException yang rapi
  static ApiException fromDioException(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.cancel:
        return ApiException(message: "Request dibatalkan.");
      case DioExceptionType.connectionTimeout:
        return ApiException(message: "Koneksi timeout.");
      case DioExceptionType.receiveTimeout:
        return ApiException(message: "Gagal menerima data (timeout).");
      case DioExceptionType.badResponse:
        return _handleBadResponse(dioError.response);
      case DioExceptionType.sendTimeout:
        return ApiException(message: "Gagal mengirim data (timeout).");
      case DioExceptionType.connectionError:
        return ApiException(message: "Tidak ada koneksi internet.");
      default:
        return ApiException(message: "Terjadi kesalahan tidak dikenal.");
    }
  }

  static ApiException _handleBadResponse(Response? response) {
    int statusCode = response?.statusCode ?? 500;
    String message = "Terjadi kesalahan server.";
    
    // Coba ambil pesan error dari body response jika backend mengirim JSON error
    try {
      if (response?.data != null && response?.data is Map) {
        message = response?.data['message'] ?? response?.data['error'] ?? message;
      }
    } catch (_) {}

    return ApiException(message: message, statusCode: statusCode);
  }
}