
// import 'dart:convert';
// import 'package:car_rental_app/models/transation_model.dart';
// import 'package:http/http.dart' as http;

// class WalletService {
//   final String baseUrl = 'https://carrentalbackent.onrender.com/api';
  
//   // Get wallet balance and transactions
//   Future<Map<String, dynamic>> getWalletDetails(String userId) async {
//     try {
//       print('oooooooooooooooooooooooooooo$userId');
//       final response = await http.get(
//         Uri.parse('https://carrentalbackent.onrender.com/api/users/getwallet/$userId'),
//         headers: {'Content-Type': 'application/json'},
//       );

//             print("fvdsjsdjhdsdjhjddjdljkjgvdlsgjdgdskgds${response.statusCode}");


//       if (response.statusCode == 200) {
//         return jsonDecode(response.body);
//       } else {
//         throw Exception('Failed to load wallet details: ${response.body}');
//       }
//     } catch (e) {
//       throw Exception('Error getting wallet details: $e');
//     }
//   }

//   // Add amount to wallet
//   Future<Map<String, dynamic>> addAmount(String userId, double amount) async {
//     try {
//       print("kkkkkkkkkkkkkkkkkkkkkkkk$userId");
//       final response = await http.post(
//         Uri.parse('https://carrentalbackent.onrender.com/api/users/addamount/$userId'),
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode({'amount': amount.toString()}),
//       );

//       print("hhhhhhhhhhhhhhhhhhhhhhh${response.statusCode}");

//       if (response.statusCode == 200) {
//         return jsonDecode(response.body);
//       } else {
//         throw Exception('Failed to add amount: ${response.body}');
//       }
//     } catch (e) {
//       throw Exception('Error adding amount: $e');
//     }
//   }

//   // Parse transactions list from JSON
//   List<Transaction> parseTransactions(List<dynamic> transactionsJson) {
//     return transactionsJson
//         .map((transaction) => Transaction.fromJson(transaction))
//         .toList();
//   }
// }



import 'dart:convert';
import 'package:car_rental_app/models/transation_model.dart';
import 'package:http/http.dart' as http;

class WalletService {
  final String baseUrl = 'https://carrentalbackent.onrender.com/api';

  // Get wallet balance and transactions
  Future<WalletResponse> getWalletDetails(String userId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/users/getwallet/$userId'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return WalletResponse.fromJson(json);
      } else {
        throw Exception('Failed to load wallet details: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error getting wallet details: $e');
    }
  }

  // Add amount to wallet
  Future<WalletResponse> addAmount(String userId, double amount) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/users/addamount/$userId'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'amount': amount}),
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return WalletResponse.fromJson(json);
      } else {
        throw Exception('Failed to add amount: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error adding amount: $e');
    }
  }
}
