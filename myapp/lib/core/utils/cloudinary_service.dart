import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'api_service.dart';

class CloudinaryService {
  static Future<String?> uploadImage(String filePath, String token) async {
    try {
      // 1. Get Signature from Backend
      final authData = await ApiService.get('/profile/signature', token: token);

      if (authData == null) {
        print('Cloudinary Error: Signature data is null');
        return null;
      }

      final String? signature = authData['signature'];
      final dynamic timestamp = authData['timestamp'];
      final String? apiKey = authData['api_key'];
      final String? cloudName = authData['cloud_name'];
      final String? folder = authData['folder'];

      if (signature == null || timestamp == null || apiKey == null || cloudName == null) {
        print('Cloudinary Error: Incomplete signature data: $authData');
        return null;
      }

      // 2. Upload directly to Cloudinary
      final url = Uri.parse('https://api.cloudinary.com/v1_1/$cloudName/image/upload');
      
      final request = http.MultipartRequest('POST', url)
        ..fields['api_key'] = apiKey
        ..fields['timestamp'] = timestamp.toString()
        ..fields['signature'] = signature;
      
      if (folder != null) {
        request.fields['folder'] = folder;
      }
      
      request.files.add(await http.MultipartFile.fromPath('file', filePath));

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      
      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        return data['secure_url'];
      } else {
        final errorMsg = 'Cloudinary Error (${response.statusCode}): ${response.body}';
        print(errorMsg);
        throw Exception(errorMsg);
      }
    } catch (e) {
      print('Cloudinary Upload Exception: $e');
      rethrow;
    }
  }
}
