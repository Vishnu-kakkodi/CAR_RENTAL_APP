import 'package:car_rental_app/models/user_model.dart';
import 'package:car_rental_app/providers/auth_provider.dart';
import 'package:car_rental_app/services/api/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthController {
  final AuthService _authService = AuthService();

  Future<bool> loginUser(BuildContext context, String mobile) async {
    try {
      final user = await _authService.login(mobile);

      if (user != null) {
        final authProvider = Provider.of<AuthProvider>(context, listen: false);
        authProvider.setUser(user);
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<String> registerUser(
    BuildContext context,
    String name,
    String email,
    String mobile,
    String referralCode,
  ) async {
    try {
      final user = await _authService.register(name, email, mobile, referralCode);
      
      if (user != null) {
        final authProvider = Provider.of<AuthProvider>(context, listen: false);
        authProvider.setUser(user);
        return user.id;
      }
      return "false";
    } catch (e) {
      debugPrint('Registration error: $e');
      return "false";
    }
  }
}