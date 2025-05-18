// import 'package:flutter/material.dart';

// class WalletScreen extends StatefulWidget {
//   const WalletScreen({super.key});

//   @override
//   State<WalletScreen> createState() => _WalletScreenState();
// }

// class _WalletScreenState extends State<WalletScreen> {
//   @override
//   Widget build(BuildContext context) {
//     // Get screen dimensions
//     final screenSize = MediaQuery.of(context).size;
//     final screenWidth = screenSize.width;
//     final screenHeight = screenSize.height;
    
//     // Calculate responsive sizes
//     final verticalSpacing = screenHeight * 0.02;
//     final horizontalPadding = screenWidth * 0.04;
//     final fontSize = MediaQuery.of(context).textScaleFactor;
    
//     return SafeArea(
//       child: Scaffold(
//         body: Padding(
//           padding: EdgeInsets.all(screenWidth * 0.02),
//           child: Column(
//             children: [
//               SizedBox(height: verticalSpacing),
//               Row(
//                 children: [
//                   Padding(
//                     padding: EdgeInsets.all(screenWidth * 0.04),
//                     child: Container(
//                       decoration: BoxDecoration(
//                         color: Colors.grey.shade200,
//                         shape: BoxShape.circle,
//                       ),
//                       child: IconButton(
//                         icon: const Icon(Icons.arrow_back, color: Colors.black),
//                         onPressed: () {
//                           Navigator.pop(context);
//                         },
//                       ),
//                     ),
//                   ),
//                   SizedBox(width: screenWidth * 0.2),
//                   Align(
//                     alignment: Alignment.center,
//                     child: Text(
//                       "Wallet",
//                       style: TextStyle(
//                         color: Colors.black,
//                         fontSize: 18 * fontSize,
//                         fontWeight: FontWeight.w800,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),

//               Container(
//                 margin: EdgeInsets.all(horizontalPadding),
//                 padding: EdgeInsets.all(horizontalPadding),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(16),
//                   boxShadow: const [
//                     BoxShadow(
//                       color: Colors.black12,
//                       blurRadius: 6,
//                       offset: Offset(0, 3),
//                     ),
//                   ],
//                 ),
//                 child: Row(
//                   children: [
//                     // Left Side - Illustration
//                     Expanded(
//                       flex: 3,
//                       child: Image.network(
//                         "https://geniusee.com/storage/app/media/blog/blog_261_humanizing_banking_experience/image4.png",
//                         fit: BoxFit.contain,
//                         height: screenHeight * 0.2,
//                       ),
//                     ),
//                     SizedBox(width: screenWidth * 0.03),
//                     // Right Side - Amount and Button
//                     Expanded(
//                       flex: 2,
//                       child: Column(
//                         children: [
//                           Align(
//                             alignment: Alignment.centerLeft,
//                             child: Text(
//                               "₹0",
//                               style: TextStyle(
//                                 fontSize: 20 * fontSize,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.black,
//                               ),
//                             ),
//                           ),
//                           SizedBox(height: screenHeight * 0.005),
//                           Align(
//                             alignment: Alignment.centerLeft,
//                             child: Text(
//                               "No wallet amount\navailable", // Forced line break
//                               style: TextStyle(
//                                 fontSize: 13 * fontSize,
//                                 color: Colors.black54,
//                               ),
//                               textAlign: TextAlign.left,
//                             ),
//                           ),
//                           SizedBox(height: screenHeight * 0.015),
//                           Align(
//                             alignment: Alignment.bottomRight,
//                             child: ElevatedButton(
//                               onPressed: () {},
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: const Color(0xFF2D1D8C),
//                                 padding: EdgeInsets.symmetric(
//                                   horizontal: screenWidth * 0.045,
//                                   vertical: screenHeight * 0.003,
//                                 ),
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(20),
//                                 ),
//                                 elevation: 0,
//                               ),
//                               child: Text(
//                                 "Add Amount",
//                                 style: TextStyle(
//                                   fontSize: 10 * fontSize,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),

//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
//                 child: Text(
//                   "Details",
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black,
//                     fontSize: 14 * fontSize,
//                   ),
//                 ),
//               ),
//               SizedBox(height: verticalSpacing * 0.6),

//               transactionTile(
//                 context: context,
//                 isReceived: true,
//                 title: "Received From",
//                 refId: "#123456",
//                 amount: "\$30",
//                 timeAgo: "1 day ago",
//               ),

//               const Divider(),

//               transactionTile(
//                 context: context,
//                 isReceived: false,
//                 title: "Paid to",
//                 refId: "#123456",
//                 amount: "\$30",
//                 timeAgo: "1 day ago",
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget transactionTile({
//     required BuildContext context,
//     required bool isReceived,
//     required String title,
//     required String refId,
//     required String amount,
//     required String timeAgo,
//   }) {
//     // Get responsive values
//     final screenWidth = MediaQuery.of(context).size.width;
//     final fontSize = MediaQuery.of(context).textScaleFactor;
    
//     return Padding(
//       padding: EdgeInsets.symmetric(
//         horizontal: screenWidth * 0.04, 
//         vertical: screenWidth * 0.015
//       ),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Arrow + Time (Left side)
//           Column(
//             children: [
//               Container(
//                 padding: EdgeInsets.all(screenWidth * 0.015),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(8),
//                   border: Border.all(width: 1, color: Colors.grey)
//                 ),
//                 child: Transform.rotate(
//                   angle: isReceived ? 0.75 : 0.75, // Radians (~43 degrees)
//                   child: Icon(
//                     isReceived ? Icons.arrow_downward : Icons.arrow_upward,
//                     color: isReceived ? Colors.green : Colors.blue,
//                     size: 20 * fontSize,
//                   ),
//                 ),
//               ),
//               SizedBox(height: screenWidth * 0.01),
//               Text(
//                 timeAgo,
//                 style: TextStyle(
//                   fontSize: 10 * fontSize, 
//                   color: Colors.grey
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(width: screenWidth * 0.03),

//           // Title + Ref ID (Middle)
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   title,
//                   style: TextStyle(
//                     fontWeight: FontWeight.w600,
//                     fontSize: 14 * fontSize,
//                   ),
//                 ),
//                 Text(
//                   "referral id : $refId",
//                   style: TextStyle(
//                     fontSize: 12 * fontSize, 
//                     color: Colors.grey
//                   ),
//                 ),
//               ],
//             ),
//           ),

//           // Amount + Status (Right)
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.end,
//             children: [
//               Text(
//                 amount,
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 14 * fontSize,
//                 ),
//               ),
//               Text(
//                 isReceived ? "Credited" : "Debited",
//                 style: TextStyle(
//                   fontSize: 10 * fontSize, 
//                   color: Colors.grey
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }




import 'package:car_rental_app/utils/storage_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/wallet_provider.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  String? userId;
 // Replace with actual user ID
  final TextEditingController _amountController = TextEditingController();
  
  @override
  void initState() {
    super.initState();
        _loadUserData();

    // Fetch wallet details when screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
    Provider.of<WalletProvider>(context, listen: false).fetchWalletDetails(userId!);
  });
    }
  
  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

Future<void> _loadUserData() async {
  try {
    final id = await StorageHelper.getUserId();
    if (mounted) {
      setState(() {
        userId = id.toString();
      });

      // Now it's safe to call fetchWalletDetails
      Provider.of<WalletProvider>(context, listen: false).fetchWalletDetails(userId!);
    }
  } catch (e) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load user data: ${e.toString()}')),
      );
    }
  }
}

  
  // Show add amount dialog
  void _showAddAmountDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Amount'),
          content: TextField(
            controller: _amountController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              hintText: 'Enter amount',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (_amountController.text.isNotEmpty) {
                  final amount = double.tryParse(_amountController.text);
                  if (amount != null && amount > 0) {
                    Provider.of<WalletProvider>(context, listen: false)
                        .addAmount(userId!, amount);
                    Navigator.pop(context);
                    _amountController.clear();
                  }
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;
    
    // Calculate responsive sizes
    final verticalSpacing = screenHeight * 0.02;
    final horizontalPadding = screenWidth * 0.04;
    final fontSize = MediaQuery.of(context).textScaleFactor;
    
    return SafeArea(
      child: Scaffold(
        body: Consumer<WalletProvider>(
          builder: (context, walletProvider, child) {
            return Padding(
              padding: EdgeInsets.all(screenWidth * 0.02),
              child: Column(
                children: [
                  SizedBox(height: verticalSpacing),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(screenWidth * 0.04),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.arrow_back, color: Colors.black),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.2),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Wallet",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18 * fontSize,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ],
                  ),

                  Container(
                    margin: EdgeInsets.all(horizontalPadding),
                    padding: EdgeInsets.all(horizontalPadding),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 6,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        // Left Side - Illustration
                        Expanded(
                          flex: 3,
                          child: Image.network(
                            "https://geniusee.com/storage/app/media/blog/blog_261_humanizing_banking_experience/image4.png",
                            fit: BoxFit.contain,
                            height: screenHeight * 0.2,
                          ),
                        ),
                        SizedBox(width: screenWidth * 0.03),
                        // Right Side - Amount and Button
                        Expanded(
                          flex: 2,
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  walletProvider.isLoading 
                                    ? "Loading..." 
                                    : "₹${walletProvider.balance.toStringAsFixed(0)}",
                                  style: TextStyle(
                                    fontSize: 20 * fontSize,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              SizedBox(height: screenHeight * 0.005),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  walletProvider.balance > 0
                                      ? "Available\nbalance"
                                      : "No wallet amount\navailable", // Forced line break
                                  style: TextStyle(
                                    fontSize: 13 * fontSize,
                                    color: Colors.black54,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              SizedBox(height: screenHeight * 0.015),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: ElevatedButton(
                                  onPressed: walletProvider.isLoading 
                                    ? null 
                                    : _showAddAmountDialog,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF2D1D8C),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: screenWidth * 0.045,
                                      vertical: screenHeight * 0.003,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    elevation: 0,
                                  ),
                                  child: Text(
                                    "Add Amount",
                                    style: TextStyle(
                                      fontSize: 10 * fontSize,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Details",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 14 * fontSize,
                          ),
                        ),
                        if (walletProvider.isLoading)
                          const SizedBox(
                            width: 20, 
                            height: 20, 
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                      ],
                    ),
                  ),
                  SizedBox(height: verticalSpacing * 0.6),

                  if (walletProvider.error.isNotEmpty)
                    Padding(
                      padding: EdgeInsets.all(horizontalPadding),
                      child: Text(
                        "Could not load transactions: ${walletProvider.error}",
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 12 * fontSize,
                        ),
                      ),
                    ),

                  Expanded(
                    child: walletProvider.transactions.isEmpty && !walletProvider.isLoading
                        ? Center(
                            child: Text(
                              "No transactions yet",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14 * fontSize,
                              ),
                            ),
                          )
                        : ListView.separated(
                            itemCount: walletProvider.transactions.length,
                            separatorBuilder: (context, index) => const Divider(),
                            itemBuilder: (context, index) {
                              final transaction = walletProvider.transactions[index];
                              final isReceived = transaction.type.toLowerCase() == 'credit';
                              
                              return transactionTile(
                                context: context,
                                isReceived: isReceived,
                                title: isReceived ? "Received From" : "Paid to",
                                refId: "#${transaction.id.substring(0, 6)}",
                                amount: "₹${transaction.amount.toStringAsFixed(0)}",
                                timeAgo: walletProvider.formatTransactionDate(transaction.date),
                              );
                            },
                          ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget transactionTile({
    required BuildContext context,
    required bool isReceived,
    required String title,
    required String refId,
    required String amount,
    required String timeAgo,
  }) {
    // Get responsive values
    final screenWidth = MediaQuery.of(context).size.width;
    final fontSize = MediaQuery.of(context).textScaleFactor;
    
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.04, 
        vertical: screenWidth * 0.015
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Arrow + Time (Left side)
          Column(
            children: [
              Container(
                padding: EdgeInsets.all(screenWidth * 0.015),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(width: 1, color: Colors.grey)
                ),
                child: Transform.rotate(
                  angle: isReceived ? 0.75 : 0.75, // Radians (~43 degrees)
                  child: Icon(
                    isReceived ? Icons.arrow_downward : Icons.arrow_upward,
                    color: isReceived ? Colors.green : Colors.blue,
                    size: 20 * fontSize,
                  ),
                ),
              ),
              SizedBox(height: screenWidth * 0.01),
              Text(
                timeAgo,
                style: TextStyle(
                  fontSize: 10 * fontSize, 
                  color: Colors.grey
                ),
              ),
            ],
          ),
          SizedBox(width: screenWidth * 0.03),

          // Title + Ref ID (Middle)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14 * fontSize,
                  ),
                ),
                Text(
                  "referral id : $refId",
                  style: TextStyle(
                    fontSize: 12 * fontSize, 
                    color: Colors.grey
                  ),
                ),
              ],
            ),
          ),

          // Amount + Status (Right)
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                amount,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14 * fontSize,
                ),
              ),
              Text(
                isReceived ? "Credited" : "Debited",
                style: TextStyle(
                  fontSize: 10 * fontSize, 
                  color: Colors.grey
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}