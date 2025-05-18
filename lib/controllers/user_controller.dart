import 'dart:io';

import 'package:car_rental_app/helpers/toast_helper.dart';
import 'package:car_rental_app/models/user_model.dart';
import 'package:car_rental_app/providers/auth_provider.dart';
import 'package:car_rental_app/services/api/user_service.dart';
import 'package:flutter/material.dart';

class UserController with ChangeNotifier {
  final UserService _userService = UserService();
  final ToastService _toast = ToastService(); // Create an instance

  bool _isUploading = false;
  bool get isUploading => _isUploading;

  void setUploading(bool value) {
    _isUploading = value;
    notifyListeners();
  }

// In UserController
Future<void> updateProfileImage({
  required BuildContext context,
  required File image,
  required String id,
  required AuthProvider authProvider,
}) async {
  setUploading(true);
  try {
    final response = await _userService.updateProfileImage(image, id);

    // Extract updated profileImage
    final updatedUser = response['user'];
    if (updatedUser != null && updatedUser['profileImage'] != null) {
      // Update the current user in AuthProvider
      UserModel? currentUser = authProvider.user;
      if (currentUser != null) {
        final updatedUserModel = UserModel(
          id: currentUser.id,
          code: currentUser.code,
          mobile: currentUser.mobile,
          name: currentUser.name,
          myBookings: currentUser.myBookings,
          profileImage: updatedUser['profileImage'],
          email: currentUser.email ?? '',
        );

        // Clear image cache
        imageCache.clear();
        imageCache.clearLiveImages();
        
        // Update user in AuthProvider
        authProvider.updateUser(updatedUserModel);
      }
    }

    _toast.showSuccess("Profile image updated successfully!");
  } catch (e) {
    print("Error uploading profile image: $e");
    _toast.showError("Failed to update profile image!");
  } finally {
    setUploading(false);
  }
}
}
