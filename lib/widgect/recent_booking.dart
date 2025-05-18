import 'package:car_rental_app/models/booking_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RecentBookingCard extends StatelessWidget {
  final Booking booking;

  const RecentBookingCard({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    final startDateTime =
        DateFormat('dd/MM/yy, hh:mm a').format(booking.rentalStartDate);
    final endDateTime =
        DateFormat('dd/MM/yy, hh:mm a').format(booking.rentalEndDate);
    return Container(
      height: 142,
      width: 343,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade400, width: 2),
          right: BorderSide(color: Colors.grey.shade400, width: 2),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            offset: const Offset(3, 3),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: OverflowBox(
        maxHeight: double.infinity,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: '${booking.car.name.split(" ").first} ',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(
                                  text: booking.car.name
                                      .split(" ")
                                      .skip(1)
                                      .join(" "),
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(Icons.settings,
                                  size: 16, color: Colors.black54),
                              const SizedBox(width: 6),
                              Text(booking.car.type,
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.grey.shade800)),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              const Icon(Icons.event_seat,
                                  size: 16, color: Colors.black54),
                              const SizedBox(width: 6),
                              Text((booking.car.seats).toString(),
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.grey.shade800)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "OTP: ${booking.otp}  ID: ${booking.id.substring(booking.id.length - 4)}",
                          style: const TextStyle(
                              fontSize: 12,
                              color: Colors.red,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 6),
                        Container(
                          width: 120,
                          height: 70,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            image: DecorationImage(
                              image: NetworkImage(booking.car.image[0]),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Text("Collect Date & time : $startDateTime",
                    style: TextStyle(fontSize: 9, color: Colors.grey.shade800)),
                const SizedBox(height: 4),
                Text("Return Date & time : $endDateTime",
                    style: TextStyle(fontSize: 9, color: Colors.grey.shade800)),
              ],
            ),
            Positioned(
              bottom: -9,
              right: -16,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: const BoxDecoration(
                  color: Color(0xFF071952),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
                child: Text(
                  '₹ ${(booking.totalPrice).toString()}/-',
                  style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
