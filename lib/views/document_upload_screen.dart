import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:car_rental_app/providers/document_provider.dart';
import 'package:image_picker/image_picker.dart';

class DocumentUploadScreen extends StatefulWidget {
  final String userId;
  
  const DocumentUploadScreen({
    Key? key,
    required this.userId,
  }) : super(key: key);

  @override
  State<DocumentUploadScreen> createState() => _DocumentUploadScreenState();
}

class _DocumentUploadScreenState extends State<DocumentUploadScreen> {
  File? _aadharFile;
  File? _licenseFile;
  final ImagePicker _picker = ImagePicker();
  bool _isUploading = false;

  Future<void> _pickImage(ImageSource source, bool isAadhar) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: source,
        imageQuality: 80,
      );
      
      if (image != null) {
        setState(() {
          if (isAadhar) {
            _aadharFile = File(image.path);
          } else {
            _licenseFile = File(image.path);
          }
        });
      }
    } catch (e) {
      print("Error picking image: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error picking image: $e')),
      );
    }
  }

  Future<void> _uploadDocuments() async {
    if (_aadharFile == null || _licenseFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select both Aadhar Card and Driving License')),
      );
      return;
    }

    setState(() {
      _isUploading = true;
    });

    try {
      await Provider.of<DocumentProvider>(context, listen: false).uploadDocuments(
        widget.userId,
        _aadharFile!,
        _licenseFile!,
      );
      
      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Documents uploaded successfully')),
      );
      
      // Go back to previous screen
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to upload documents: $e')),
      );
    } finally {
      setState(() {
        _isUploading = false;
      });
    }
  }

  void _showImageSourceDialog(bool isAadhar) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(isAadhar ? 'Upload Aadhar Card' : 'Upload Driving License'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Take a Photo'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.camera, isAadhar);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Choose from Gallery'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.gallery, isAadhar);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;
    
    // Calculate responsive sizes
    final verticalSpacing = screenHeight * 0.03;
    final containerHeight = screenHeight * 0.25;
    final padding = screenWidth * 0.02;
    
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: const Text("Upload Documents"),
          centerTitle: true,
          elevation: 0,
        ),
        body: Padding(
          padding: EdgeInsets.all(padding),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: verticalSpacing),
                Text(
                  "Aadhar Card",
                  style: TextStyle(
                    fontSize: screenWidth * 0.045,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Please upload a clear image of your Aadhar Card",
                  style: TextStyle(
                    fontSize: screenWidth * 0.035,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: verticalSpacing * 0.5),
                GestureDetector(
                  onTap: () => _showImageSourceDialog(true),
                  child: Container(
                    height: containerHeight,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.grey[300]!,
                        width: 1,
                      ),
                    ),
                    child: _aadharFile != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.file(
                              _aadharFile!,
                              fit: BoxFit.cover,
                            ),
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.upload_file,
                                size: screenWidth * 0.15,
                                color: Colors.grey[400],
                              ),
                              SizedBox(height: verticalSpacing * 0.5),
                              Text(
                                "Tap to upload Aadhar Card",
                                style: TextStyle(
                                  fontSize: screenWidth * 0.04,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
                
                SizedBox(height: verticalSpacing * 1.5),
                
                Text(
                  "Driving License",
                  style: TextStyle(
                    fontSize: screenWidth * 0.045,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Please upload a clear image of your Driving License",
                  style: TextStyle(
                    fontSize: screenWidth * 0.035,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: verticalSpacing * 0.5),
                GestureDetector(
                  onTap: () => _showImageSourceDialog(false),
                  child: Container(
                    height: containerHeight,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.grey[300]!,
                        width: 1,
                      ),
                    ),
                    child: _licenseFile != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.file(
                              _licenseFile!,
                              fit: BoxFit.cover,
                            ),
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.upload_file,
                                size: screenWidth * 0.15,
                                color: Colors.grey[400],
                              ),
                              SizedBox(height: verticalSpacing * 0.5),
                              Text(
                                "Tap to upload Driving License",
                                style: TextStyle(
                                  fontSize: screenWidth * 0.04,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
                
                SizedBox(height: verticalSpacing * 2),
                
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isUploading ? null : _uploadDocuments,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0XFF1E0AFE),
                      padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      disabledBackgroundColor: Colors.grey,
                    ),
                    child: _isUploading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : Text(
                            "Upload Documents",
                            style: TextStyle(
                              color: Colors.white, 
                              fontSize: screenWidth * 0.04,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}