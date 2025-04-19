import 'package:flutter/material.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Row(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
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
                  const SizedBox(width: 90),
                  Align(
                    alignment: Alignment.center,
                    child: const Text(
                      "Wallet",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ],
              ),

              Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
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
                        height: 163,
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Right Side - Amount and Button
                    Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: const Text(
                              "₹0",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: const Text(
                              "No wallet amount\navailable", // Forced line break
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.black54,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF2D1D8C),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 18,
                                  vertical: 2,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                elevation: 0,
                              ),
                              child: const Text(
                                "Add Amount",
                                style: TextStyle(
                                  fontSize: 10,
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

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  "Details",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 12),

              transactionTile(
                isReceived: true,
                title: "Received From",
                refId: "#123456",
                amount: "\$30",
                timeAgo: "1 day ago",
              ),

              Divider(),

              transactionTile(
                isReceived: false,
                title: "Paid to",
                refId: "#123456",
                amount: "\$30",
                timeAgo: "1 day ago",
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget transactionTile({
    required bool isReceived,
    required String title,
    required String refId,
    required String amount,
    required String timeAgo,
  }) {
    return Padding(
  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
  child: Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // Arrow + Time (Left side)
      Column(
        children: [
Container(
  padding: const EdgeInsets.all(6),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(8),
    border: Border.all(width: 1,color: Colors.grey)
  ),
  child: Transform.rotate(
    angle: isReceived ? 0.75 : 0.75, // Radians (~43 degrees)
    child: Icon(
      isReceived ? Icons.arrow_downward : Icons.arrow_upward,
      color: isReceived ? Colors.green : Colors.blue,
      size: 20,
    ),
  ),
),

          const SizedBox(height: 4),
          Text(
            timeAgo,
            style: const TextStyle(fontSize: 10, color: Colors.grey),
          ),
        ],
      ),
      const SizedBox(width: 12),

      // Title + Ref ID (Middle)
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            Text(
              "referral id : $refId",
              style: const TextStyle(fontSize: 12, color: Colors.grey),
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
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          Text(
            isReceived ? "Credited" : "Debited",
            style: const TextStyle(fontSize: 10, color: Colors.grey),
          ),
        ],
      ),
    ],
  ),
);

  }
}
