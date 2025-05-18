import 'dart:io';
import 'package:car_rental_app/controllers/user_controller.dart';
import 'package:car_rental_app/providers/auth_provider.dart';
import 'package:car_rental_app/utils/storage_helper.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<EditProfile> {
  String name = '';
  String email = '';
  String mobile = '';
  @override
  void initState() {
    super.initState();
    // Refresh profile image when screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AuthProvider>(context, listen: false).refreshProfileImage();
    });
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    // Load all user data
    final userName = await StorageHelper.getUserName();
    final userEmail = await StorageHelper.getEmail();
    final userMobile = await StorageHelper.getMobile();

    // Update state with the retrieved values
    setState(() {
      name = userName ?? '';
      email = userEmail ?? '';
      mobile = userMobile ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;
    final paddingValue = screenWidth * 0.04;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.all(paddingValue * 0.25),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: Icon(Icons.arrow_back,
                  color: Colors.black, size: screenWidth * 0.06),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
        title: Text(
          "Edit Profile",
          style: TextStyle(
            color: Colors.black,
            fontSize: screenWidth * 0.045,
            fontWeight: FontWeight.w800,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(paddingValue),
        child: ListView(
          children: [
            SizedBox(height: screenHeight * 0.025),

            // Profile Image
            Center(
              child: Consumer<AuthProvider>(
                builder: (context, authProvider, child) {
                  return Stack(
                    children: [
                      _buildProfileImage(context, authProvider, screenWidth),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () =>
                              _updateProfileImage(context, authProvider),
                          child: Container(
                            padding: EdgeInsets.all(screenWidth * 0.015),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  spreadRadius: 1,
                                  blurRadius: 3,
                                ),
                              ],
                            ),
                            child: Icon(
                              Icons.edit,
                              size: screenWidth * 0.05,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),

            SizedBox(height: screenHeight * 0.05),

            // Name Field (Non-editable)
            _buildInfoField(
              context,
              label: "Name",
              value: name,
              screenWidth: screenWidth,
              screenHeight: screenHeight,
            ),

            SizedBox(height: screenHeight * 0.03),

            // Mobile Field (Non-editable)
            _buildInfoField(
              context,
              label: "Mobile Number",
              value: mobile,
              screenWidth: screenWidth,
              screenHeight: screenHeight,
            ),

            SizedBox(height: screenHeight * 0.03),

            // Email Field (Non-editable)
            _buildInfoField(
              context,
              label: "Email",
              value: email,
              screenWidth: screenWidth,
              screenHeight: screenHeight,
            ),
          ],
        ),
      ),
    );
  }

Widget _buildProfileImage(BuildContext context, AuthProvider authProvider, double screenWidth) {
  // First check the authProvider
  final profileImageFromAuth = authProvider.user?.profileImage;
  
  // Use a FutureBuilder to handle the async loading of the profile image from storage
  return FutureBuilder<String?>(
    future: StorageHelper.getProfileImage(),
    builder: (context, snapshot) {
      // Show a loading indicator if we're still waiting for the data
      if (snapshot.connectionState == ConnectionState.waiting) {
        return CircleAvatar(
          radius: screenWidth * 0.125,
          backgroundColor: Colors.grey[200],
          child: CircularProgressIndicator(),
        );
      }
      
      // Determine which image URL to use based on available sources
      String imageUrl;
      
      if (profileImageFromAuth != null) {
        // If image is available from auth provider, use it
        imageUrl = profileImageFromAuth;
      } else if (snapshot.hasData && snapshot.data != null && snapshot.data!.isNotEmpty) {
        // Otherwise use the image from storage if available
        imageUrl = snapshot.data!;
      } else {
        // Default image if no other source is available
        imageUrl = 'https://avatar.iran.liara.run/public/boy?username=Ash';
      }
      
      // Format the URL properly if it's a relative path
      if (imageUrl.isNotEmpty && !imageUrl.startsWith('http')) {
        imageUrl = 'https://carrentalbackent.onrender.com$imageUrl';
      }
      
      // Add cache buster
      final cacheBuster = '?t=${DateTime.now().millisecondsSinceEpoch}';
      
      // Return the CircleAvatar with the determined image URL
      return CircleAvatar(
        key: ValueKey('$imageUrl$cacheBuster'),
        radius: screenWidth * 0.125,
        backgroundColor: Colors.grey[200],
        backgroundImage: NetworkImage('$imageUrl$cacheBuster'),
        onBackgroundImageError: (exception, stackTrace) {
          print("Error loading profile image: $exception");
        },
      );
    },
  );
}

  Future<void> _updateProfileImage(
      BuildContext context, AuthProvider authProvider) async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      final userId = await StorageHelper.getUserId();
      if (userId != null) {
        // Show loading indicator
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) =>
              const Center(child: CircularProgressIndicator()),
        );

        try {
          // Update profile image
          await Provider.of<UserController>(context, listen: false)
              .updateProfileImage(
            context: context,
            image: File(image.path),
            id: userId,
            authProvider: authProvider,
          );

          // Force image cache clearing
          imageCache.clear();
          imageCache.clearLiveImages();

          // Refresh the auth provider which will notify all listeners
          await authProvider.refreshProfileImage();
        } catch (e) {
          print("Error updating profile image: $e");
        } finally {
          // Close loading dialog
          if (mounted && Navigator.canPop(context)) {
            Navigator.of(context).pop();
          }
        }
      }
    }
  }

  Widget _buildInfoField(
    BuildContext context, {
    required String label,
    required String value,
    required double screenWidth,
    required double screenHeight,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: screenWidth * 0.035,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: screenHeight * 0.01),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.04,
            vertical: screenHeight * 0.02,
          ),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(screenWidth * 0.02),
            color: Colors.grey.shade100,
          ),
          child: Text(
            value,
            style: TextStyle(
              fontSize: screenWidth * 0.04,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }
}
