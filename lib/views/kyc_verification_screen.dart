// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:provider/provider.dart';

// import 'package:car_rental_app/views/home_screen.dart';
// import 'package:car_rental_app/widgect/blurred_circle.dart';
// import 'package:car_rental_app/providers/document_provider.dart';

// class KycVerificationScreen extends StatefulWidget {
//   final String userId;
//   const KycVerificationScreen({super.key, required this.userId});

//   @override
//   State<KycVerificationScreen> createState() => _KycVerificationScreenState();
// }

// class _KycVerificationScreenState extends State<KycVerificationScreen> {
//   File? _aadharFile;
//   File? _licenseFile;

//   final ImagePicker _picker = ImagePicker();

//   Future<void> _pickImage(bool isAadhar) async {
//     final picked = await _picker.pickImage(source: ImageSource.gallery);
//     if (picked != null) {
//       setState(() {
//         if (isAadhar) {
//           _aadharFile = File(picked.path);
//         } else {
//           _licenseFile = File(picked.path);
//         }
//       });
//     }
//   }

//   void _submitDocuments(BuildContext context) async {
//     if (_aadharFile == null || _licenseFile == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Please upload both documents')),
//       );
//       return;
//     }

//     final provider = Provider.of<DocumentProvider>(context, listen: false);
//     await provider.uploadDocuments(widget.userId, _aadharFile!, _licenseFile!);

//     if (provider.errorMessage != null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text(provider.errorMessage!)),
//       );
//     } else {
//       showVerificationDialog(context);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<DocumentProvider>(context);
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Stack(
//         children: [
//           Container(
//             decoration: BoxDecoration(
//               color: Colors.black,
//               border: Border.all(color: Colors.black, width: 2),
//             ),
//           ),
//           const Positioned(
//             top: -100,
//             left: -100,
//             child: BlurredCircle(color: Color(0xFF2E2EFF)),
//           ),
//           const Positioned(
//             top: 100,
//             left: 200,
//             child: BlurredCircle(color: Color(0xFF2E2EFF)),
//           ),
//           Align(
//             alignment: Alignment.bottomCenter,
//             child: Container(
//               height: 500,
//               width: double.infinity,
//               padding: const EdgeInsets.all(24),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: const BorderRadius.only(
//                   topLeft: Radius.circular(40),
//                   topRight: Radius.circular(40),
//                 ),
//                 border: Border.all(color: Colors.black, width: 2),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const SizedBox(height: 24),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       const Text(
//                         'KYC Verification',
//                         style: TextStyle(
//                           fontWeight: FontWeight.w600,
//                           fontSize: 20,
//                         ),
//                       ),
//                       Container(
//                         width: 30,
//                         height: 30,
//                         decoration: const BoxDecoration(
//                           shape: BoxShape.circle,
//                           gradient: SweepGradient(
//                             colors: [
//                               Color.fromARGB(255, 53, 103, 188),
//                               Color.fromARGB(255, 53, 15, 206),
//                             ],
//                           ),
//                         ),
//                         child: const Center(
//                           child: CircleAvatar(
//                             backgroundColor: Colors.white,
//                             radius: 13,
//                             child: Text(
//                               '2',
//                               style: TextStyle(
//                                 color: Color(0xFF0D0350),
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 32),

//                   // Aadhaar Upload
//                   GestureDetector(
//                     onTap: () => _pickImage(true),
//                     child: Container(
//                       height: 60,
//                       padding: const EdgeInsets.symmetric(horizontal: 16),
//                       decoration: BoxDecoration(
//                         border: Border.all(),
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       child: Row(
//                         children: [
//                           const Icon(Icons.file_upload_outlined, color: Colors.red),
//                           const SizedBox(width: 12),
//                           Text(
//                             _aadharFile != null
//                                 ? 'Aadhaar Selected'
//                                 : 'Upload Aadhaar Card',
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),

//                   const SizedBox(height: 16),

//                   // License Upload
//                   GestureDetector(
//                     onTap: () => _pickImage(false),
//                     child: Container(
//                       height: 60,
//                       padding: const EdgeInsets.symmetric(horizontal: 16),
//                       decoration: BoxDecoration(
//                         border: Border.all(),
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       child: Row(
//                         children: [
//                           const Icon(Icons.file_upload_outlined, color: Colors.red),
//                           const SizedBox(width: 12),
//                           Text(
//                             _licenseFile != null
//                                 ? 'License Selected'
//                                 : 'Upload Driving License',
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),

//                   const SizedBox(height: 40),

//                   provider.isLoading
//                       ? const Center(child: CircularProgressIndicator())
//                       : SizedBox(
//                           height: 46,
//                           width: double.infinity,
//                           child: ElevatedButton(
//                             onPressed: () => _submitDocuments(context),
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: const Color(0xFF0A20AF),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(8),
//                               ),
//                             ),
//                             child: const Text(
//                               "Verify",
//                               style: TextStyle(color: Colors.white),
//                             ),
//                           ),
//                         ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   void showVerificationDialog(BuildContext context) {
//     showGeneralDialog(
//       context: context,
//       barrierDismissible: false,
//       barrierLabel: "Dialog",
//       barrierColor: Colors.black.withOpacity(0.5),
//       transitionDuration: const Duration(milliseconds: 300),
//       pageBuilder: (context, animation1, animation2) {
//         return Center(
//           child: Material(
//             type: MaterialType.transparency,
//             child: Container(
//               width: MediaQuery.of(context).size.width - 48,
//               height: 470,
//               padding: const EdgeInsets.all(24),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   const SizedBox(height: 25),
//                   Image.asset('assets/loading.jpeg', height: 100),
//                   const SizedBox(height: 20),
//                   const Text(
//                     'Documents are under verification',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
//                   ),
//                   const SizedBox(height: 20),
//                   const Text(
//                     'Book the car at low cost and enjoy the\ntrip with your family',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(fontSize: 14, color: Colors.black54),
//                   ),
//                   const SizedBox(height: 40),
//                   SizedBox(
//                     width: double.infinity,
//                     child: ElevatedButton(
//                       onPressed: () {
//                         Navigator.pop(context);
//                         Navigator.pushReplacement(
//                           context,
//                           MaterialPageRoute(builder: (ctx) => const HomeScreen()),
//                         );
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: const Color(0xFF001AFF),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                       ),
//                       child: const Padding(
//                         padding: EdgeInsets.symmetric(vertical: 12),
//                         child: Text(
//                           'Proceed',
//                           style: TextStyle(color: Colors.white),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }








import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:car_rental_app/views/login_screen.dart';

import 'package:car_rental_app/views/home_screen.dart';
import 'package:car_rental_app/widgect/blurred_circle.dart';
import 'package:car_rental_app/providers/document_provider.dart';

class KycVerificationScreen extends StatefulWidget {
  final String userId;
  const KycVerificationScreen({super.key, required this.userId});

  @override
  State<KycVerificationScreen> createState() => _KycVerificationScreenState();
}

class _KycVerificationScreenState extends State<KycVerificationScreen> {
  File? _aadharFile;
  File? _licenseFile;
  bool _isUploading = false;

  final ImagePicker _picker = ImagePicker();

  // Show image source selection dialog (camera or gallery)
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

  // Pick image from camera or gallery
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

  // Upload documents to server
  Future<void> _submitDocuments(BuildContext context) async {
    // Validate both documents are selected
    if (_aadharFile == null || _licenseFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please upload both documents')),
      );
      return;
    }

    // Show loading state
    setState(() {
      _isUploading = true;
    });

    try {
      // Upload documents using provider
      final provider = Provider.of<DocumentProvider>(context, listen: false);
      await provider.uploadDocuments(widget.userId, _aadharFile!, _licenseFile!);

      // Check for errors
      if (provider.errorMessage != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(provider.errorMessage!)),
        );
      } else {
        // Show verification dialog on success
        showVerificationDialog(context);
      }
    } catch (e) {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to upload documents: $e')),
      );
    } finally {
      // Reset loading state
      setState(() {
        _isUploading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DocumentProvider>(context);
    
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.black,
              border: Border.all(color: Colors.black, width: 2),
            ),
          ),
          const Positioned(
            top: -100,
            left: -100,
            child: BlurredCircle(color: Color(0xFF2E2EFF)),
          ),
          const Positioned(
            top: 100,
            left: 200,
            child: BlurredCircle(color: Color(0xFF2E2EFF)),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 500,
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                border: Border.all(color: Colors.black, width: 2),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'KYC Verification',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                      ),
                      Container(
                        width: 30,
                        height: 30,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: SweepGradient(
                            colors: [
                              Color.fromARGB(255, 53, 103, 188),
                              Color.fromARGB(255, 53, 15, 206),
                            ],
                          ),
                        ),
                        child: const Center(
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 13,
                            child: Text(
                              '2',
                              style: TextStyle(
                                color: Color(0xFF0D0350),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),

                  // Aadhaar Upload
                  GestureDetector(
                    onTap: () => _showImageSourceDialog(true),
                    child: Container(
                      height: 60,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.file_upload_outlined, color: Colors.red),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              _aadharFile != null
                                  ? 'Aadhaar Selected: ${_aadharFile!.path.split('/').last}'
                                  : 'Upload Aadhaar Card',
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (_aadharFile != null)
                            IconButton(
                              icon: const Icon(Icons.remove_circle_outline, color: Colors.red),
                              onPressed: () {
                                setState(() {
                                  _aadharFile = null;
                                });
                              },
                            ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // License Upload
                  GestureDetector(
                    onTap: () => _showImageSourceDialog(false),
                    child: Container(
                      height: 60,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.file_upload_outlined, color: Colors.red),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              _licenseFile != null
                                  ? 'License Selected: ${_licenseFile!.path.split('/').last}'
                                  : 'Upload Driving License',
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (_licenseFile != null)
                            IconButton(
                              icon: const Icon(Icons.remove_circle_outline, color: Colors.red),
                              onPressed: () {
                                setState(() {
                                  _licenseFile = null;
                                });
                              },
                            ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),

                  _isUploading || provider.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : SizedBox(
                          height: 46,
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () => _submitDocuments(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF0A20AF),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              "Verify",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showVerificationDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierLabel: "Dialog",
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation1, animation2) {
        return Center(
          child: Material(
            type: MaterialType.transparency,
            child: Container(
              width: MediaQuery.of(context).size.width - 48,
              height: 470,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 25),
                  Image.asset('assets/loading.png', height: 100),
                  const SizedBox(height: 20),
                  const Text(
                    'Documents are under verification',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Book the car at low cost and enjoy the\ntrip with your family',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (ctx) => const LoginScreen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF001AFF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        child: Text(
                          'Proceed',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}