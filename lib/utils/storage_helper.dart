import 'package:shared_preferences/shared_preferences.dart';

class StorageHelper {
  static const String _userIdKey = 'userId';
  static const String _userName = 'userName';
  static const String _mobile = 'mobile';
  static const String _email = 'email';
  static const String _profileImage = 'profileImage';
  static const String _token = 'token';
  static const String _code = 'code';

  static Future<void> saveUserId(String userId, String userName, String mobile,
      String? profileImage, String code,
      [String email = '']) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userIdKey, userId);
    await prefs.setString(_userName, userName);
    await prefs.setString(_mobile, mobile);
    await prefs.setString(_profileImage, profileImage!);

    await prefs.setString(_code, code);

    if (email.isNotEmpty) {
      await prefs.setString(_email, email);
    }
  }

  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_token, token);
  }

  static Future<void> updateProfileImage(
    String userId,
    String userName,
    String mobile,
    String email,
    String profileImage,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userIdKey, userId);
    await prefs.setString(_userName, userName);
    await prefs.setString(_mobile, mobile);

    if (email.isNotEmpty) {
      await prefs.setString(_email, email);
    }

    await prefs.setString(_profileImage, profileImage);
  }

  static Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userIdKey);
  }

  static Future<String?> getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userName);
  }

  static Future<String?> getMobile() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_mobile);
  }

  static Future<String?> getEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_email);
  }

  static Future<String?> getCode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_code);
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_token);
  }

  static Future<String?> getProfileImage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_profileImage);
  }

  static Future<void> clearUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userIdKey);
    await prefs.remove(_userName);
    await prefs.remove(_mobile);
    await prefs.remove(_email);
    await prefs.remove(_profileImage);
    await prefs.remove(_token);
  }
}
