// import 'dart:io';
// import 'package:car_rental_app/services/api/document_service.dart';
// import 'package:flutter/material.dart';
// import '../models/document_model.dart';

// class DocumentProvider with ChangeNotifier {
//   final DocumentService _service = DocumentService();

//   UploadedDocuments? uploadedDocuments;
//   bool isLoading = false;
//   String? errorMessage;

//   Future<void> uploadDocuments(String userId, File aadharFile, File licenseFile) async {
//     isLoading = true;
//     errorMessage = null;
//     notifyListeners();

//     try {
//       uploadedDocuments = await _service.uploadDocuments(
//         userId: userId,
//         aadharFile: aadharFile,
//         licenseFile: licenseFile,
//       );
//     } catch (e) {
//       errorMessage = e.toString();
//     }

//     isLoading = false;
//     notifyListeners();
//   }
// }





import 'dart:io';
import 'package:car_rental_app/services/api/document_service.dart';
import 'package:flutter/material.dart';
import '../models/document_model.dart';

class DocumentProvider with ChangeNotifier {
  final DocumentService _service = DocumentService();

  UploadedDocuments? uploadedDocuments;
  bool isLoading = false;
  String? errorMessage;

  // Fetch user documents
  Future<void> fetchDocuments(String userId) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      uploadedDocuments = await _service.getDocuments(userId);
    } catch (e) {
      errorMessage = e.toString();
      print("Error fetching documents: $e");
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> uploadDocuments(String userId, File aadharFile, File licenseFile) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      uploadedDocuments = await _service.uploadDocuments(
        userId: userId,
        aadharFile: aadharFile,
        licenseFile: licenseFile,
      );
    } catch (e) {
      errorMessage = e.toString();
      print("Error in provider: $e");
    }

    isLoading = false;
    notifyListeners();
  }
  
  // Get document status string with proper formatting
  String getFormattedStatus(String status) {
    if (status == 'pending') {
      return 'Pending Verification';
    } else if (status == 'approved') {
      return 'Verified';
    } else if (status == 'rejected') {
      return 'Rejected';
    } else {
      return 'Unknown Status';
    }
  }
  
  // Get color based on document status
  Color getStatusColor(String status) {
    if (status == 'pending') {
      return Colors.orange;
    } else if (status == 'approved') {
      return Colors.green;
    } else if (status == 'rejected') {
      return Colors.red;
    } else {
      return Colors.grey;
    }
  }
}