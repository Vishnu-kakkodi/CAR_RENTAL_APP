// // class UserModel{
// //   final String id;
// //   final String mobile;
// //   final String name;
// //   final List<String> myBookings;
// //   final String? profileImage;

// //   UserModel({
// //     required this.id,
// //     required this.mobile,
// //     required this.name,
// //     required this.myBookings,
// //     this.profileImage,
// //   });

// //   factory UserModel.fromJson(Map<String,dynamic> json){
// //     return UserModel(id: json['_id'], mobile: json['mobile'], name: json['name'], myBookings: List<String>.from(json['myBookings']), profileImage: json['profileImage']);
// //   }

// //   Map<String, dynamic> toJson(){
// //     final data =  {
// //       '_id': id,
// //       'mobile':mobile,
// //       'name': name,
// //       'myBookings': myBookings
// //     };

// //     final String? image = profileImage;
// //     if(image != null && image!.isNotEmpty){
// //       data['profileImage'] = image;
// //     }

// //     return data;
// //   }
// // }




// class UserModel {
//   final String id;
//   final String mobile;
//   final String name;
//   final List<String> myBookings;
//   final String? profileImage;

//   UserModel({
//     required this.id,
//     required this.mobile,
//     required this.name,
//     required this.myBookings,
//     this.profileImage,
//   });

//   factory UserModel.fromJson(Map<String, dynamic> json) {
//     return UserModel(
//       id: json['_id'],
//       mobile: json['mobile'],
//       name: json['name'],
//       myBookings: List<String>.from(json['myBookings']),
//       profileImage: json['profileImage'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     final data = {
//       '_id': id,
//       'mobile': mobile,
//       'name': name,
//       'myBookings': myBookings,
//     };

//     if (profileImage != null && profileImage!.isNotEmpty) {
//       data['profileImage'] = profileImage!;
//     }

//     return data;
//   }

//   // ✅ Add this copyWith method
//   UserModel copyWith({
//     String? id,
//     String? mobile,
//     String? name,
//     List<String>? myBookings,
//     String? profileImage,
//   }) {
//     return UserModel(
//       id: id ?? this.id,
//       mobile: mobile ?? this.mobile,
//       name: name ?? this.name,
//       myBookings: myBookings ?? this.myBookings,
//       profileImage: profileImage ?? this.profileImage,
//     );
//   }
// }




class UserModel {
  final String id;
  final String mobile;
  final String name;
  final String? email;
  final List<String> myBookings;
  final String? profileImage;
  final String code;
  final List<dynamic>? wallet;

  UserModel({
    required this.id,
    required this.mobile,
    required this.name,
    this.email,
    required this.myBookings,
    this.profileImage,
    required this.code,
    this.wallet,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    // Handle both "_id" (from server) and "id" (if we've transformed it)
    final id = json['_id'] ?? json['id'];
    
    return UserModel(
      id: id,
      mobile: json['mobile'],
      name: json['name'],
      email: json['email'],
      // Handle case where myBookings might not be present in the response
      myBookings: json['myBookings'] != null
          ? List<String>.from(json['myBookings'])
          : [],
      profileImage: json['profileImage'],
      code: json['code'],
      wallet: json['wallet'],
    );
  }

  Map<String, dynamic> toJson() {
    final data = {
      '_id': id,
      'mobile': mobile,
      'name': name,
      'myBookings': myBookings,
    };

    // Add optional fields if they exist
    if (email != null && email!.isNotEmpty) {
      data['email'] = email!;
    }
    
    if (profileImage != null && profileImage!.isNotEmpty) {
      data['profileImage'] = profileImage!;
    }
    
    
    if (wallet != null) {
      data['wallet'] = wallet!;
    }

    return data;
  }

  UserModel copyWith({
    String? id,
    String? mobile,
    String? name,
    String? email,
    List<String>? myBookings,
    String? profileImage,
    String? code,
    List<dynamic>? wallet,
  }) {
    return UserModel(
      id: id ?? this.id,
      mobile: mobile ?? this.mobile,
      name: name ?? this.name,
      email: email ?? this.email,
      myBookings: myBookings ?? this.myBookings,
      profileImage: profileImage ?? this.profileImage,
      code: code ?? this.code,
      wallet: wallet ?? this.wallet,
    );
  }
}