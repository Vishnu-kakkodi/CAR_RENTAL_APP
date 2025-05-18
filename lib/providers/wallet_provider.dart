// import 'package:car_rental_app/models/transation_model.dart';
// import 'package:car_rental_app/services/api/wallet_service.dart';
// import 'package:flutter/material.dart';

// class WalletProvider extends ChangeNotifier {
//   final WalletService _walletService = WalletService();
  
//   double _balance = 0.0;
//   List<Transaction> _transactions = [];
//   bool _isLoading = false;
//   String _error = '';
  
//   // Getters
//   double get balance => _balance;
//   List<Transaction> get transactions => _transactions;
//   bool get isLoading => _isLoading;
//   String get error => _error;
  
//   // Initialize wallet data
//   Future<void> fetchWalletDetails(String userId) async {
//     try {
//       _isLoading = true;
//       _error = '';
//       notifyListeners();
      
//       final walletData = await _walletService.getWalletDetails(userId);
      
//       // Update balance and transactions
//       if (walletData.containsKey('balance')) {
//         _balance = double.parse(walletData['balance'].toString());
//       }
      
//       if (walletData.containsKey('wallet') && walletData['wallet'] is List) {
//         _transactions = _walletService.parseTransactions(walletData['wallet']);
//       }
      
//       _isLoading = false;
//       notifyListeners();
//     } catch (e) {
//       _isLoading = false;
//       _error = e.toString();
//       notifyListeners();
//     }
//   }
  
//   // Add amount to wallet
//   Future<void> addAmount(String userId, double amount) async {
//     try {
//       _isLoading = true;
//       _error = '';
//       notifyListeners();
      
//       final response = await _walletService.addAmount(userId, amount);
      
//       // Update wallet with new transaction
//       if (response.containsKey('transaction')) {
//         // Add the new transaction to the list
//         if (response.containsKey('wallet') && response['wallet'] is List) {
//           _transactions = _walletService.parseTransactions(response['wallet']);
//         }
        
//         // Update balance
//         _balance += amount;
//       }
      
//       _isLoading = false;
//       notifyListeners();
//     } catch (e) {
//       _isLoading = false;
//       _error = e.toString();
//       notifyListeners();
//     }
//   }
  
//   // Format transaction date
//   String formatTransactionDate(DateTime date) {
//     final now = DateTime.now();
//     final difference = now.difference(date);
    
//     if (difference.inDays == 0) {
//       if (difference.inHours == 0) {
//         return '${difference.inMinutes} minutes ago';
//       }
//       return '${difference.inHours} hours ago';
//     } else if (difference.inDays == 1) {
//       return '1 day ago';
//     } else if (difference.inDays < 30) {
//       return '${difference.inDays} days ago';
//     } else {
//       return '${date.day}/${date.month}/${date.year}';
//     }
//   }
// }




import 'package:car_rental_app/models/transation_model.dart';
import 'package:car_rental_app/services/api/wallet_service.dart';
import 'package:flutter/material.dart';

class WalletProvider extends ChangeNotifier {
  final WalletService _walletService = WalletService();

  double _balance = 0.0;
  List<Transaction> _transactions = [];
  bool _isLoading = false;
  String _error = '';

  // Getters
  double get balance => _balance;
  List<Transaction> get transactions => _transactions;
  bool get isLoading => _isLoading;
  String get error => _error;

  // Initialize wallet data
  Future<void> fetchWalletDetails(String userId) async {
    try {
      _isLoading = true;
      _error = '';
      notifyListeners();

      final walletResponse = await _walletService.getWalletDetails(userId);

      _balance = walletResponse.totalWalletAmount.toDouble();
      _transactions = walletResponse.wallet;

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
    }
  }

  // Add amount to wallet
Future<void> addAmount(String userId, double amount) async {
  try {
    _isLoading = true;
    notifyListeners();

    // Call API to add amount
await _walletService.addAmount(userId, amount);

    // Refresh wallet data
    await fetchWalletDetails(userId);

    _isLoading = false;
    notifyListeners();
  } catch (e) {
    _error = e.toString();
    _isLoading = false;
    notifyListeners();
  }
}


  // Format transaction date
  String formatTransactionDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      if (difference.inHours == 0) {
        return '${difference.inMinutes} minutes ago';
      }
      return '${difference.inHours} hours ago';
    } else if (difference.inDays == 1) {
      return '1 day ago';
    } else if (difference.inDays < 30) {
      return '${difference.inDays} days ago';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }
}
