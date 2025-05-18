// import 'dart:convert';

// import 'package:car_rental_app/models/user_model.dart';
// import 'package:http/http.dart' as http;

// class AuthService{
//   final String baseUrl = 'https://carrentalbackent.onrender.com/api';

//   Future<UserModel?> login(String mobile) async {
//     try{
//           print("Mobile Number: $mobile");
//     final response = await http.post(
//       Uri.parse('https://carrentalbackent.onrender.com/api/users/login'),
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode({'mobile':mobile}),
//     );
//     print('${response.statusCode}');

//     if(response.statusCode == 200){
//       final data = jsonDecode(response.body);
//       print("datttttttttttttttt$data");
//       return UserModel.fromJson(data['user']);
//     }else{
//       throw Exception("Login Failed");
//     }
//   }catch(e){
//     print('Errrrrrrrrrrrr$e');
//   }
//     return null;
//     }
// }




import 'dart:convert';

import 'package:car_rental_app/helpers/toast_helper.dart';
import 'package:car_rental_app/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthService {
  final String baseUrl = 'https://carrentalbackent.onrender.com/api';
    final ToastService _toast = ToastService(); // Create an instance


  Future<UserModel?> login(String mobile) async {
    try {
      debugPrint("Mobile Number: $mobile");
      final response = await http.post(
        Uri.parse('$baseUrl/users/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'mobile': mobile}),
      );
      debugPrint('Status code: ${response.statusCode}');

      

      if (response.statusCode == 200) {
                _toast.showSuccess("Login successful!"); // Show success toast
        final data = jsonDecode(response.body);
        debugPrint("Response data: $data");
        return UserModel.fromJson(data['user']);
      } else {
        _toast..showError("Login Failed!");
      }
    } catch (e) {
      debugPrint('Login error: $e');
      return null;
    }
  }

  Future<UserModel?> register(
    String name,
    String email,
    String mobile,
    String referralCode,
  ) async {
    try {
      final Map<String, dynamic> payload = {
        "name": name,
        "email": email,
        "mobile": mobile,
      };
      
      // Only add referral code if it's not empty
      if (referralCode.isNotEmpty) {
        payload["code"] = referralCode;
      }

      debugPrint("Registration payload: $payload");
      
      final response = await http.post(
        Uri.parse('$baseUrl/users/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(payload),
      );
      
      debugPrint('Registration status code: ${response.statusCode}');
      
      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        debugPrint("Registration response: $data");
        
        // Save token somewhere if needed
        final token = data['token'];
        
        return UserModel.fromJson(data['user']);
      } else {
        final errorData = jsonDecode(response.body);
        throw Exception("Registration Failed: ${errorData['message'] ?? 'Unknown error'}");
      }
    } catch (e) {
      debugPrint('Registration error: $e');
      rethrow;
    }
  }
}