import 'package:car_rental_app/models/user_model.dart';
import 'package:car_rental_app/services/api/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier{
  final AuthService _authService = AuthService();
  UserModel? _user;

  UserModel? get user => _user;

  Future<bool> login(String mobile) async {
    try{
      final userData = await _authService.login(mobile);
      _user = userData;
      notifyListeners();
      return true;
    }catch(e){
      return false;
    }
  }

  void setUser(UserModel user) async {
    _user = user;
      // Save userdata to sharedpreference
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('userId', _user!.id);
      await prefs.setString('userName', _user!.name);
      await prefs.setString('mobile', _user!.mobile);
  }
}