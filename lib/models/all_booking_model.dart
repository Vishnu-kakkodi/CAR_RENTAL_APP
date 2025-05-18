class AllBookings {
  final String id;
  final String userId;
  final Car car;
  final DateTime rentalStartDate;
  final DateTime rentalEndDate;
  final int totalPrice;
  final String status;
  final String paymentStatus;
  final int otp;
  final DateTime createdAt;
  final DateTime updatedAt;

  AllBookings({
    required this.id,
    required this.userId,
    required this.car,
    required this.rentalStartDate,
    required this.rentalEndDate,
    required this.totalPrice,
    required this.status,
    required this.paymentStatus,
    required this.otp,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AllBookings.fromJson(Map<String, dynamic> json) {
    return AllBookings(
      id: json['_id'],
      userId: json['userId'],
      car: Car.fromJson(json['carId']),
      rentalStartDate: DateTime.parse(json['rentalStartDate']),
      rentalEndDate: DateTime.parse(json['rentalEndDate']),
      totalPrice: json['totalPrice'],
      status: json['status'],
      paymentStatus: json['paymentStatus'],
      otp: json['otp'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'userId': userId,
      'carId': car.toJson(),
      'rentalStartDate': rentalStartDate.toIso8601String(),
      'rentalEndDate': rentalEndDate.toIso8601String(),
      'totalPrice': totalPrice,
      'status': status,
      'paymentStatus': paymentStatus,
      'otp': otp,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}

class Car {
  final String id;
  final String carName;
  final String model;
  final int year;
  final int pricePerHour;
  final String description;
  final bool availabilityStatus;
  final List<String> carImage;
  final String location;
  final String carType;
  final String fuel;
  final int seats;
  final String type;
  final DateTime createdAt;
  final DateTime updatedAt;

  Car({
    required this.id,
    required this.carName,
    required this.model,
    required this.year,
    required this.pricePerHour,
    required this.description,
    required this.availabilityStatus,
    required this.carImage,
    required this.location,
    required this.carType,
    required this.fuel,
    required this.seats,
    required this.type,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
      id: json['_id'],
      carName: json['carName'],
      model: json['model'],
      year: json['year'],
      pricePerHour: json['pricePerHour'],
      description: json['description'],
      availabilityStatus: json['availabilityStatus'],
      carImage: List<String>.from(json['carImage']),
      location: json['location'],
      carType: json['carType'],
      fuel: json['fuel'],
      seats: json['seats'],
      type: json['type'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'carName': carName,
      'model': model,
      'year': year,
      'pricePerHour': pricePerHour,
      'description': description,
      'availabilityStatus': availabilityStatus,
      'carImage': carImage,
      'location': location,
      'carType': carType,
      'fuel': fuel,
      'seats': seats,
      'type': type,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
