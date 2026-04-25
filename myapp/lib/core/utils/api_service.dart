import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class ApiService {
  static const String baseUrl = 'http://10.0.2.2:5000/api'; // Use 10.0.2.2 for Android Emulator

  static Map<String, String> _getHeaders(String? token) {
    return {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  static Future<dynamic> post(String path, Map<String, dynamic> body, {String? token}) async {
    final url = Uri.parse('$baseUrl$path');
    print('DEBUG: [POST] $url');
    print('DEBUG: Body: ${jsonEncode(body)}');

    try {
      final response = await http.post(
        url,
        headers: _getHeaders(token),
        body: jsonEncode(body),
      ).timeout(const Duration(seconds: 30));

      print('DEBUG: Response Status: ${response.statusCode}');
      return _processResponse(response);
    } on SocketException catch (e) {
      print('DEBUG ERROR: SocketException - ${e.message}');
      throw 'Không thể kết nối tới Server. Vui lòng kiểm tra mạng của máy ảo và đảm bảo Backend đang chạy.';
    } catch (e) {
      print('DEBUG ERROR: $e');
      rethrow;
    }
  }

  static Future<dynamic> put(String path, Map<String, dynamic> body, {String? token}) async {
    final url = Uri.parse('$baseUrl$path');
    print('DEBUG: [PUT] $url');
    try {
      final response = await http.put(
        url,
        headers: _getHeaders(token),
        body: jsonEncode(body),
      ).timeout(const Duration(seconds: 30));
      return _processResponse(response);
    } catch (e) {
      print('DEBUG ERROR: $e');
      rethrow;
    }
  }

  static Future<dynamic> get(String path, {String? token, Map<String, String>? queryParams}) async {
    Uri url = Uri.parse('$baseUrl$path');
    if (queryParams != null && queryParams.isNotEmpty) {
      url = url.replace(queryParameters: queryParams);
    }
    
    print('DEBUG: [GET] $url');

    try {
      final response = await http.get(
        url,
        headers: _getHeaders(token),
      ).timeout(const Duration(seconds: 30));

      print('DEBUG: Response Status: ${response.statusCode}');
      return _processResponse(response);
    } on SocketException catch (e) {
      print('DEBUG ERROR: SocketException - ${e.message}');
      throw 'Kết nối mạng bị lỗi (Unreachable).';
    } catch (e) {
      print('DEBUG ERROR: $e');
      rethrow;
    }
  }

  static Future<dynamic> delete(String path, {String? token}) async {
    final url = Uri.parse('$baseUrl$path');
    print('DEBUG: [DELETE] $url');

    try {
      final response = await http.delete(
        url,
        headers: _getHeaders(token),
      ).timeout(const Duration(seconds: 30));

      print('DEBUG: Response Status: ${response.statusCode}');
      return _processResponse(response);
    } on SocketException catch (e) {
      print('DEBUG ERROR: SocketException - ${e.message}');
      throw 'Kết nối mạng bị lỗi (Unreachable).';
    } catch (e) {
      print('DEBUG ERROR: $e');
      rethrow;
    }
  }

  static Future<dynamic> uploadMedia(String path, List<String> filePaths, {String? token}) async {
    final url = Uri.parse('$baseUrl$path');
    print('DEBUG: [UPLOAD] $url');
    final request = http.MultipartRequest('POST', url);
    
    if (token != null) {
      request.headers['Authorization'] = 'Bearer $token';
    }

    for (String filePath in filePaths) {
      request.files.add(
        await http.MultipartFile.fromPath(
          'photos', 
          filePath,
          contentType: MediaType('image', 'jpeg'),
        ),
      );
    }

    try {
      final streamedResponse = await request.send().timeout(const Duration(seconds: 30));
      final response = await http.Response.fromStream(streamedResponse);
      print('DEBUG: Response Status: ${response.statusCode}');
      return _processResponse(response);
    } on SocketException catch (e) {
      print('DEBUG ERROR: SocketException - ${e.message}');
      throw 'Kết nối mạng bị lỗi khi upload.';
    } catch (e) {
      print('DEBUG ERROR: $e');
      rethrow;
    }
  }

  static dynamic _processResponse(http.Response response) {
    print('DEBUG: Response from ${response.request?.url} - Status: ${response.statusCode}');
    dynamic body;
    try {
      body = jsonDecode(response.body);
      print('DEBUG: Response Body Length: ${response.body.length}');
    } catch (e) {
      print('DEBUG ERROR: Non-JSON response body: ${response.body}');
      throw 'Server trả về định dạng không hợp lệ. Vui lòng kiểm tra Backend.';
    }

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return body;
    }
    
    final String errorMessage = body is Map ? (body['error'] ?? body['message'] ?? 'Đã có lỗi xảy ra') : 'Lỗi hệ thống (${response.statusCode})';
    print('DEBUG ERROR: API Error: $errorMessage');
    throw errorMessage;
  }

  static String formatImageUrl(String? url) {
    if (url == null || url.isEmpty) return 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=500';
    if (url.startsWith('http')) return url;
    // Remove /api from baseUrl to get root
    final rootUrl = baseUrl.replaceAll('/api', '');
    return '$rootUrl$url';
  }
}
