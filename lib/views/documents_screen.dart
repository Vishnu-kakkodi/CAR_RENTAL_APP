

import 'package:car_rental_app/views/document_upload_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:car_rental_app/providers/document_provider.dart';
import 'package:car_rental_app/models/document_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Documents extends StatefulWidget {
  const Documents({Key? key}) : super(key: key);

  @override
  State<Documents> createState() => _DocumentsState();
}

class _DocumentsState extends State<Documents> {
  late String userId;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _getUserIdAndFetchDocuments();
  }

  Future<void> _getUserIdAndFetchDocuments() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      userId = prefs.getString('userId') ?? '';
      
      if (userId.isNotEmpty) {
        await Provider.of<DocumentProvider>(context, listen: false).fetchDocuments(userId);
      } else {
        print('User ID not found in SharedPreferences');
      }
    } catch (e) {
      print('Error getting user ID: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;
        final paddingValue = screenWidth * 0.04;

    
    // Calculate responsive sizes
    final verticalSpacing = screenHeight * 0.03;
    final containerHeight = screenHeight * 0.18;
    final padding = screenWidth * 0.02;
    
    return SafeArea(
      child: Scaffold(
                        appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.all(paddingValue * 0.7),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: Icon(Icons.arrow_back,
                  color: Colors.black, size: screenWidth * 0.05),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
        title: Text(
          "Documents",
          style: TextStyle(
            color: Colors.black,
            fontSize: screenWidth * 0.045,
            fontWeight: FontWeight.w800,
          ),
        ),
        centerTitle: true,
      ),
        body: Consumer<DocumentProvider>(
          builder: (context, documentProvider, child) {
            if (documentProvider.isLoading || isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (documentProvider.errorMessage != null) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Error: ${documentProvider.errorMessage}',
                      style: TextStyle(color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                    ElevatedButton(
                      onPressed: () => _getUserIdAndFetchDocuments(),
                      child: Text('Retry'),
                    ),
                  ],
                ),
              );
            }

            final documents = documentProvider.uploadedDocuments;

            return Padding(
              padding: EdgeInsets.all(padding),
              child: Column(
                children: [
                  SizedBox(height: screenHeight * 0.05),       
                  // Documents list or centered message
                  Expanded(
                    child: _hasDocuments(documents)
                    ? SingleChildScrollView(
                        child: Column(
                          children: [
                            // Aadhar Card (if exists)
                            if (documents != null && documents.aadharCard != null) ...[
                              _buildDocumentCard(
                                context,
                                title: "Aadhar Card",
                                documentInfo: documents.aadharCard,
                                containerHeight: containerHeight,
                                provider: documentProvider,
                              ),
                              SizedBox(height: verticalSpacing),
                            ],
                            
                            // Driving License (if exists)
                            if (documents != null && documents.drivingLicense != null) ...[
                              _buildDocumentCard(
                                context,
                                title: "Driving License",
                                documentInfo: documents.drivingLicense,
                                containerHeight: containerHeight,
                                provider: documentProvider,
                              ),
                            ],
                          ],
                        ),
                      )
                    : Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.description_outlined,
                              size: screenWidth * 0.15,
                              color: Colors.grey,
                            ),
                            SizedBox(height: screenHeight * 0.02),
                            Text(
                              "No documents found",
                              style: TextStyle(
                                fontSize: screenWidth * 0.045,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.01),
                            Text(
                              "Please upload your documents",
                              style: TextStyle(
                                fontSize: screenWidth * 0.04,
                                color: Colors.grey.shade700,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                  ),
                  
                  // Upload/Edit button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => DocumentUploadScreen(userId: userId),
                          ),
                        ).then((_) {
                          // Refresh documents when returning from upload screen
                          _getUserIdAndFetchDocuments();
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0XFF1E0AFE),
                        padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        _getUploadButtonText(documents),
                        style: TextStyle(
                          color: Colors.white, 
                          fontSize: screenWidth * 0.04
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: padding * 2),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildDocumentCard(
    BuildContext context, {
    required String title,
    required DocumentInfo documentInfo,
    required double containerHeight,
    required DocumentProvider provider,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;
    
    return Container(
      height: containerHeight,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          // Document image preview
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8),
              bottomLeft: Radius.circular(8),
            ),
            child: Container(
              width: containerHeight * 0.8,
              height: containerHeight,
              color: Colors.grey.shade100,
              child: CachedNetworkImage(
                imageUrl: documentInfo.url,
                fit: BoxFit.fill,
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => const Center(
                  child: Icon(Icons.error, color: Colors.red),
                ),
              ),
            ),
          ),
          
          // Document details
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: screenWidth * 0.04,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Uploaded: ${_formatDate(documentInfo.uploadedAt)}",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: screenWidth * 0.032,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: provider.getStatusColor(documentInfo.status).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          _getStatusIcon(documentInfo.status),
                          color: provider.getStatusColor(documentInfo.status),
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          provider.getFormattedStatus(documentInfo.status),
                          style: TextStyle(
                            color: provider.getStatusColor(documentInfo.status),
                            fontWeight: FontWeight.w500,
                            fontSize: screenWidth * 0.03,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // View button
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: IconButton(
              icon: const Icon(Icons.visibility, color: Color(0XFF1E0AFE)),
              onPressed: () {
                _showDocumentPreview(context, title, documentInfo.url);
              },
            ),
          ),
        ],
      ),
    );
  }

  // Check if any documents exist
  bool _hasDocuments(UploadedDocuments? documents) {
    if (documents == null) return false;
    return documents.aadharCard != null || documents.drivingLicense != null;
  }
  
  // Get appropriate button text based on document status
  String _getUploadButtonText(UploadedDocuments? documents) {
    if (documents == null) return "Upload Documents";
    if (documents.aadharCard == null || documents.drivingLicense == null) {
      return "Complete Documents";
    }
    return "Edit Documents";
  }

  IconData _getStatusIcon(String status) {
    if (status == 'pending') {
      return Icons.pending_actions;
    } else if (status == 'approved') {
      return Icons.check_circle;
    } else if (status == 'rejected') {
      return Icons.cancel;
    } else {
      return Icons.question_mark;
    }
  }

  void _showDocumentPreview(BuildContext context, String title, String imageUrl) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppBar(
                title: Text(title),
                centerTitle: true,
                leading: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
              InteractiveViewer(
                panEnabled: true,
                boundaryMargin: const EdgeInsets.all(20),
                minScale: 0.5,
                maxScale: 4,
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  fit: BoxFit.contain,
                  height: MediaQuery.of(context).size.height * 0.6,
                  width: double.infinity,
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Center(
                    child: Icon(Icons.error, color: Colors.red, size: 50),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

    String _formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}";
  }
  
}