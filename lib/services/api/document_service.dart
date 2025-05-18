// import 'dart:convert';
// import 'dart:io';
// import 'package:car_rental_app/models/document_model.dart';
// import 'package:http/http.dart' as http;
// import 'package:http_parser/http_parser.dart'; // For MediaType

// class DocumentService {
//   Future<UploadedDocuments> uploadDocuments({
//     required String userId,
//     required File aadharFile,
//     required File licenseFile,
//   }) async {
//     print("Uploading documents for user: $userId");

//     final uri = Uri.parse('https://carrentalbackent.onrender.com/api/users/uploaddocuments/$userId');
//     final request = http.MultipartRequest('POST', uri);

//     // Helper to get content type based on extension
//     MediaType? getMediaType(String path) {
//       final ext = path.split('.').last.toLowerCase();
//       switch (ext) {
//         case 'jpg':
//         case 'jpeg':
//           return MediaType('image', 'jpeg');
//         case 'png':
//           return MediaType('image', 'png');
//         default:
//           throw Exception('Unsupported file type: $ext');
//       }
//     }

//     request.files.add(
//       await http.MultipartFile.fromPath(
//         'adharCard',
//         aadharFile.path,
//         contentType: getMediaType(aadharFile.path),
//       ),
//     );

//     request.files.add(
//       await http.MultipartFile.fromPath(
//         'drivingLicense',
//         licenseFile.path,
//         contentType: getMediaType(licenseFile.path),
//       ),
//     );

//     final streamedResponse = await request.send();
//     final response = await http.Response.fromStream(streamedResponse);

//     print("Response code: ${response.statusCode}");
//     print("Response body: ${response.body}");

//     if (response.statusCode == 200 || response.statusCode == 201) {
//       final data = json.decode(response.body);
//       return UploadedDocuments.fromJson(data['documents']);
//     } else {
//       throw Exception('Failed to upload documents: ${response.body}');
//     }
//   }
// }






import 'dart:convert';
import 'dart:io';
import 'package:car_rental_app/models/document_model.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart'; // For MediaType

class DocumentService {
  final String baseUrl = 'https://carrentalbackent.onrender.com/api';

  // Get documents
  Future<UploadedDocuments> getDocuments(String userId) async {
    print("Fetching documents for user: $userId");
    
    final uri = Uri.parse('$baseUrl/users/documents/$userId');
    final response = await http.get(uri);
    
    print("Response code: ${response.statusCode}");
    print("Response body: ${response.body}");
    
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return UploadedDocuments.fromJson(data['documents']);
    } else {
      throw Exception('Failed to fetch documents: ${response.body}');
    }
  }

Future<UploadedDocuments> uploadDocuments({
  required String userId,
  required File aadharFile,
  required File licenseFile,
}) async {
  print("Uploading documents for user: $userId");

  final uri = Uri.parse('$baseUrl/users/uploaddocuments/$userId');
  final request = http.MultipartRequest('POST', uri);

  // Helper to get content type based on extension
  MediaType? getMediaType(String path) {
    final ext = path.split('.').last.toLowerCase();
    switch (ext) {
      case 'jpg':
      case 'jpeg':
        return MediaType('image', 'jpeg');
      case 'png':
        return MediaType('image', 'png');
      case 'pdf':
        return MediaType('application', 'pdf');
      default:
        throw Exception('Unsupported file type: $ext');
    }
  }

  // Add files to request with proper field names
  // Fix: Using correct field name 'aadharCard' instead of 'adharCard'
  request.files.add(
    await http.MultipartFile.fromPath(
      'aadharCard', // Fixed spelling to match backend expectation
      aadharFile.path,
      contentType: getMediaType(aadharFile.path),
    ),
  );

  request.files.add(
    await http.MultipartFile.fromPath(
      'drivingLicense',
      licenseFile.path,
      contentType: getMediaType(licenseFile.path),
    ),
  );

  try {
    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    print("Response code: ${response.statusCode}");
    print("Response body: ${response.body}");

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = json.decode(response.body);
      return UploadedDocuments.fromJson(data['documents']);
    } else {
      throw Exception('Failed to upload documents: ${response.body}');
    }
  } catch (e) {
    print("Error uploading documents: $e");
    throw Exception('Error uploading documents: $e');
  }
}
}