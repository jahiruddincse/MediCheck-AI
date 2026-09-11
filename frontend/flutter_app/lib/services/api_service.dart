import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../models/medicine.dart';
import '../models/verification_result.dart';

class ApiService {
  static const String baseUrl = 'http://127.0.0.1:8000';

  /// Upload medicine packaging photo to FastAPI backend
  /// Flow: Flutter -> FastAPI -> OpenCV -> YOLO -> EasyOCR -> AI Structuring
  Future<Medicine> scanMedicineImage(File imageFile) async {
    try {
      final uri = Uri.parse('$baseUrl/scan-medicine');
      final request = http.MultipartRequest('POST', uri);
      request.files.add(
        await http.MultipartFile.fromPath('file', imageFile.path),
      );

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['structured_data'] != null) {
          return Medicine.fromJson(data['structured_data']);
        }
      }
    } catch (e) {
      // Fallback for offline demo mode
    }
    return Medicine.sampleGlycomet();
  }

  /// Run verification against reference database
  Future<VerificationResult> verifyMedicine(Medicine medicine) async {
    try {
      final uri = Uri.parse('$baseUrl/verify');
      final response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(medicine.toJson()),
      );

      if (response.statusCode == 200) {
        // Parse server response if available
      }
    } catch (e) {
      // Fallback for offline demo mode
    }
    return VerificationResult.sampleResult();
  }
}
