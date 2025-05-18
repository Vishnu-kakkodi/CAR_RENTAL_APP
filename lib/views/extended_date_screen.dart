import 'package:flutter/material.dart';

class ExtendDatePage extends StatefulWidget {
  const ExtendDatePage({super.key});

  @override
  _ExtendDatePageState createState() => _ExtendDatePageState();
}

class _ExtendDatePageState extends State<ExtendDatePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.5),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  "Select Extend Date",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 20),

              Row(
                children: [
                  Container(
                    width: 72,
                    height: 37,
                    decoration: BoxDecoration(
                      color: const Color(0xFF1600C8),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Align(
                      alignment: Alignment.center,
                      child: Text(
                        "1hr",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Container(
                    width: 72,
                    height: 37,
                    decoration: BoxDecoration(
                      color: const Color(0xFF1600C8),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Align(
                      alignment: Alignment.center,
                      child: Text(
                        "2hr",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              Row(
                children: [
                  Container(
                    width: 72,
                    height: 37,
                    decoration: BoxDecoration(
                      color: const Color(0xFF1600C8),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Align(
                      alignment: Alignment.center,
                      child: Text(
                        "1hr",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Container(
                    width: 72,
                    height: 37,
                    decoration: BoxDecoration(
                      color: const Color(0xFF1600C8),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Align(
                      alignment: Alignment.center,
                      child: Text(
                        "2hr",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              const Text(
                "Delivery date",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 15),

              Container(
                width: 306,
                height: 55,
                decoration: BoxDecoration(
                  color: const Color(0xFF1600C8),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: 103,
                      height: 35,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 255, 255, 255),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(2.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Sat,Nov 2',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(width: 10),
                            Icon(Icons.calendar_month, size: 18,),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: 103,
                      height: 35,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 255, 255, 255),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(2.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '10:00 AM',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(width: 10),
                            Icon(Icons.timer_outlined, size: 18),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 15),

              const Text(
                "Extend date",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 15),

              Container(
                width: 306,
                height: 55,
                decoration: BoxDecoration(
                  color: const Color(0xFF1600C8),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: 103,
                      height: 35,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 6.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                '--/--/----',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                  decorationStyle: TextDecorationStyle.dotted,
                                ),
                              ),
                            ),
                            SizedBox(width: 5),
                            Icon(Icons.calendar_month, size: 18),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: 103,
                      height: 35,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 6.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '00:00 AA',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Icon(Icons.timer_outlined, size: 18),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              Column(
                children: [
                  infoRow("Outstanding", 1500),
                  infoRow("Extend", 1500),
                  const Divider(height: 20, thickness: 1, color: Colors.grey),
                  infoRow("Total", 1500),
                ],
              ),
              const SizedBox(height: 20),
              Center(
                child: Container(
                  width: 244,
                  height: 48,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: const Color(0xFF120698),
                  ),
                  child: const Center(
                    child: Text(
                      "Extend",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 24,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget infoRow(String title, double amount) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(title), Text('₹${amount.toStringAsFixed(2)}')],
      ),
    );
  }
}
