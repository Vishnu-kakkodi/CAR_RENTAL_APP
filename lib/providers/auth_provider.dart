// // import 'package:car_rental_app/models/user_model.dart';
// // import 'package:car_rental_app/services/api/auth_service.dart';
// // import 'package:car_rental_app/utils/storage_helper.dart';
// // import 'package:flutter/material.dart';
// // import 'package:shared_preferences/shared_preferences.dart';

// // class AuthProvider extends ChangeNotifier{
// //   final AuthService _authService = AuthService();
// //   UserModel? _user;

// //   UserModel? get user => _user;

// //   Future<bool> login(String mobile) async {
// //     try{
// //       final userData = await _authService.login(mobile);
// //       _user = userData;
// //       notifyListeners();
// //       return true;
// //     }catch(e){
// //       return false;
// //     }
// //   }

// //   void setUser(UserModel user) async {
// //     _user = user;
// //       await StorageHelper.saveUserId(user.id, user.name, user.mobile);
// //   }

// //     void updateUser(UserModel user) async {
// //     _user = user;
// //       await StorageHelper.updateProfileImage(user.id, user.name, user.mobile, user.profileImage!);
// //   }
// // }




// import 'package:car_rental_app/models/user_model.dart';
// import 'package:car_rental_app/utils/storage_helper.dart';
// import 'package:flutter/material.dart';

// class AuthProvider with ChangeNotifier {
//   UserModel? _user;
//   String? _localImageUrl;

//   UserModel? get user => _user;

//   String get localImageUrl => _localImageUrl ??
//       'https://avatar.iran.liara.run/public/boy?username=Ash';

//   Future<void> loadProfileImage() async {
//     final profileImage = _user?.profileImage ?? await StorageHelper.getProfileImage();

//     if (profileImage != null) {
//       _localImageUrl = 'https://carrentalbackent.onrender.com$profileImage';
//     } else {
//       _localImageUrl =
//           'https://avatar.iran.liara.run/public/boy?username=Ash';
//     }

//     notifyListeners();
//   }

//   void setUser(UserModel user) {
//     _user = user;
//     StorageHelper.saveUserId(user.id, user.name, user.mobile);
//     notifyListeners();
//   }

//   Future<void> updateProfileImage(String imagePath) async {
//     if (_user != null) {
//       await StorageHelper.updateProfileImage(
//         _user!.id,
//         _user!.name,
//         _user!.mobile,
//         imagePath,
//       );
//       _user = _user!.copyWith(profileImage: imagePath);
//       await loadProfileImage();
//     }
//   }

//   void updateUser(UserModel updatedUser) async {
//   _user = updatedUser;

//   await StorageHelper.updateProfileImage(
//     updatedUser.id,
//     updatedUser.name,
//     updatedUser.mobile,
//     updatedUser.profileImage ?? '',
//   );

//   await loadProfileImage(); // updates _localImageUrl
//   notifyListeners();
// }


//   void logout() {
//     _user = null;
//     _localImageUrl = null;
//     StorageHelper.clearUserId();
//     notifyListeners();
//   }
// }



import 'package:car_rental_app/models/user_model.dart';
import 'package:car_rental_app/utils/storage_helper.dart';
import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  UserModel? _user;
  String? _localImageUrl;
  String? _token;

  UserModel? get user => _user;
  String? get token => _token;

  String get localImageUrl => _localImageUrl ??
      'https://avatar.iran.liara.run/public/boy?username=Ash';

  Future<void> loadProfileImage() async {
    final profileImage = _user?.profileImage ?? await StorageHelper.getProfileImage();

    if (profileImage != null && profileImage.isNotEmpty) {
      _localImageUrl = 'https://carrentalbackent.onrender.com$profileImage';
    } else {
      _localImageUrl =
          'https://avatar.iran.liara.run/public/boy?username=Ash';
    }

    notifyListeners();
  }

  void setUser(UserModel user) {
    _user = user;
    
    // Save essential user info to shared preferences
    StorageHelper.saveUserId(
      user.id, 
      user.name, 
      user.mobile,
      user.profileImage,
      user.code,
      user.email ?? '',
    );
    
    loadProfileImage();
    notifyListeners();
  }

  void setToken(String token) {
    _token = token;
    StorageHelper.saveToken(token);
    notifyListeners();
  }

  Future<void> updateProfileImage(String imagePath) async {
    if (_user != null) {
      await StorageHelper.updateProfileImage(
        _user!.id,
        _user!.name,
        _user!.mobile,
        _user!.email ?? '',
        imagePath,
      );
      _user = _user!.copyWith(profileImage: imagePath);
      await loadProfileImage();
    }
  }

// Make sure your authProvider notifies properly
void updateUser(UserModel updatedUser) {
  _user = updatedUser;
  
  // First notify listeners to update UI
  notifyListeners();
  
  // Then save to storage
  StorageHelper.updateProfileImage(
    updatedUser.id,
    updatedUser.name,
    updatedUser.mobile,
    updatedUser.email ?? '',
    updatedUser.profileImage ?? '',
  ).then((_) {
    // Load profile image again and notify listeners again
    loadProfileImage().then((_) {
      notifyListeners();
    });
  });
}

// Add this method to your AuthProvider class
Future<void> refreshProfileImage() async {
  // Clear image cache
  imageCache.clear();
  imageCache.clearLiveImages();
  
  // Reload profile image from storage
  await loadProfileImage();
  
  // Notify listeners about the change
  notifyListeners();
}

  Future<bool> init() async {
    final userId = await StorageHelper.getUserId();
    final token = await StorageHelper.getToken();
    
    if (userId != null) {
      // You could load the full user profile from API here if needed
      final name = await StorageHelper.getUserName();
      final mobile = await StorageHelper.getMobile();
      final email = await StorageHelper.getEmail();
      final code = await StorageHelper.getCode();
      final profileImage = await StorageHelper.getProfileImage();
      
      _user = UserModel(
        id: userId,
        name: name ?? '',
        mobile: mobile ?? '',
        email: email,
        code: code ?? '',
        myBookings: [],
        profileImage: profileImage,
      );
      
      _token = token;
      await loadProfileImage();
      notifyListeners();
      return true;
    }
    return false;
  }

  void logout() {
    _user = null;
    _localImageUrl = null;
    _token = null;
    StorageHelper.clearUserData();
    notifyListeners();
  }
}