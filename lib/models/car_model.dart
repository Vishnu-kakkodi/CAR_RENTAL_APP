// class Car {
//   final String id;
//   final String name;
//   final String model;
//   final int year;
//   final int pricePerHour;
//   final String description;
//   final bool availabilityStatus;
//   final String image;
//   final String location;
//   final String carType;
//   final String fuel;
//   final int seats;
//   final String type;

//   Car({
//     required this.id,
//     required this.name,
//     required this.model,
//     required this.year,
//     required this.pricePerHour,
//     required this.description,
//     required this.availabilityStatus,
//     required this.image,
//     required this.location,
//     required this.carType,
//     required this.fuel,
//     required this.seats,
//     required this.type,
//   });

//   factory Car.fromJson(Map<String, dynamic> json) {
//     return Car(
//       id: json['_id'],
//       name: json['carName'],
//       model: json['model'],
//       year: json['year'],
//       pricePerHour: json['pricePerHour'],
//       description: json['description'],
//       availabilityStatus: json['availabilityStatus'],
//       image: json['carImage'],
//       location: json['location'],
//       carType: json['carType'],
//       fuel: json['fuel'],
//       seats: json['seats'],
//       type: json['type'],
//     );
//   }
// }

// class Car {
//   final String id;
//   final String name;
//   final String model;
//   final int year;
//   final int pricePerHour;
//   final String description;
//   final bool availabilityStatus;
//   final String image;
//   final String location;
//   final String carType;
//   final String fuel;
//   final int seats;
//   final String type;

//   Car({
//     required this.id,
//     required this.name,
//     required this.model,
//     required this.year,
//     required this.pricePerHour,
//     required this.description,
//     required this.availabilityStatus,
//     required this.image,
//     required this.location,
//     required this.carType,
//     required this.fuel,
//     required this.seats,
//     required this.type,
//   });

//   factory Car.fromJson(Map<String, dynamic> json) {
//     return Car(
//       id: json['_id'] ?? '',
//       name: json['carName'] ?? 'Unknown',
//       model: json['model'] ?? 'Unknown',
//       year: json['year'] ?? 0,
//       pricePerHour: json['pricePerHour'] ?? 0,
//       description: json['description'] ?? '',
//       availabilityStatus: json['availabilityStatus'] ?? false,
//       image: json['carImage'] ?? '',
//       location: json['location'] ?? '',
//       carType: json['carType'] ?? '',
//       fuel: json['fuel'] ?? '',
//       seats: json['seats'] ?? 0,
//       type: json['type'] ?? '',
//     );
//   }
// }

// class Car {
//   final String id;
//   final String name;
//   final String image;
//   final String location;
//   final String type;
//   final String fuel;
//   final int seats;
//   final int pricePerHour;
//   final bool isAvailable;
//   final bool isFavorite;
//   final Map<String, dynamic>? additionalDetails;

//   Car({
//     required this.id,
//     required this.name,
//     required this.image,
//     required this.location,
//     required this.type,
//     required this.fuel,
//     required this.seats,
//     required this.pricePerHour,
//     this.isAvailable = true,
//     this.isFavorite = false,
//     this.additionalDetails,
//   });

//   factory Car.fromJson(Map<String, dynamic> json) {
//     return Car(
//       id: json['_id'] ?? '',
//       name: json['name'] ?? '',
//       image: json['image'] ?? '',
//       location: json['location'] ?? '',
//       type: json['type'] ?? '',
//       fuel: json['fuel'] ?? '',
//       seats: json['seats'] ?? '',
//       pricePerHour: json['pricePerHour'] ?? 0,
//       isAvailable: json['isAvailable'] ?? true,
//       additionalDetails: json['additionalDetails'] != null
//           ? Map<String, dynamic>.from(json['additionalDetails'])
//           : null,
//     );
//   }

//   // Create empty car for cases when no car is found
//   factory Car.empty() {
//     return Car(
//       id: '',
//       name: '',
//       image: '',
//       location: '',
//       type: '',
//       fuel: '',
//       seats:0,
//       pricePerHour: 0,
//       isAvailable: false,
//     );
//   }

//   // Create a copy with optional changed fields
//   Car copyWith({
//     String? id,
//     String? name,
//     String? image,
//     String? location,
//     String? type,
//     String? fuel,
//     int? pricePerHour,
//     bool? isAvailable,
//     bool? isFavorite,
//     Map<String, dynamic>? additionalDetails,
//   }) {
//     return Car(
//       id: id ?? this.id,
//       name: name ?? this.name,
//       image: image ?? this.image,
//       location: location ?? this.location,
//       type: type ?? this.type,
//       fuel: fuel ?? this.fuel,
//       seats: seats ?? this.seats,
//       pricePerHour: pricePerHour ?? this.pricePerHour,
//       isAvailable: isAvailable ?? this.isAvailable,
//       isFavorite: isFavorite ?? this.isFavorite,
//       additionalDetails: additionalDetails ?? this.additionalDetails,
//     );
//   }

//   // Check if car is empty
//   bool get isEmpty => id.isEmpty;
// }




// class Car {
//   final String id;
//   final String name;
//   final String model;
//   final int year;
//   final int pricePerHour;
//   final String description;
//   final bool availabilityStatus;
//   final String image;
//   final String location;
//   final String carType;
//   final String fuel;
//   final int seats;
//   final String type;

//   Car({
//     required this.id,
//     required this.name,
//     required this.model,
//     required this.year,
//     required this.pricePerHour,
//     required this.description,
//     required this.availabilityStatus,
//     required this.image,
//     required this.location,
//     required this.carType,
//     required this.fuel,
//     required this.seats,
//     required this.type,
//   });

//   factory Car.fromJson(Map<String, dynamic> json) {
//     return Car(
//       id: json['_id'],
//       name: json['carName'],
//       model: json['model'],
//       year: json['year'],
//       pricePerHour: json['pricePerHour'],
//       description: json['description'],
//       availabilityStatus: json['availabilityStatus'],
//       image: json['carImage'],
//       location: json['location'],
//       carType: json['carType'],
//       fuel: json['fuel'],
//       seats: json['seats'],
//       type: json['type'],
//     );
//   }
// }




class Car {
  final String id;
  final String name;
  final String model;
  final int year;
  final int pricePerHour;
  final String description;
  final bool availabilityStatus;
  final List<String> image;
  final String location;
  final String carType;
  final String fuel;
  final int seats;
  final String type;

  Car({
    required this.id,
    required this.name,
    required this.model,
    required this.year,
    required this.pricePerHour,
    required this.description,
    required this.availabilityStatus,
    required this.image,
    required this.location,
    required this.carType,
    required this.fuel,
    required this.seats,
    required this.type,
  });

  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
      id: json['_id'],
      name: json['carName'],
      model: json['model'],
      year: json['year'],
      pricePerHour: json['pricePerHour'],
      description: json['description'],
      availabilityStatus: json['availabilityStatus'],
      image: List<String>.from(json['carImage']), // ✅ List parsing
      location: json['location'],
      carType: json['carType'],
      fuel: json['fuel'],
      seats: json['seats'],
      type: json['type'],
    );
  }
}
