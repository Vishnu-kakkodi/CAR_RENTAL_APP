class UserModel{
  final String id;
  final String mobile;
  final String name;
  final List<String> myBookings;

  UserModel({
    required this.id,
    required this.mobile,
    required this.name,
    required this.myBookings
  });

  factory UserModel.fromJson(Map<String,dynamic> json){
    return UserModel(id: json['_id'], mobile: json['mobile'], name: json['name'], myBookings: List<String>.from(json['myBookings']));
  }

  Map<String, dynamic> toJson(){
    return {
      '_id': id,
      'mobile':mobile,
      'name': name,
      'myBookings': myBookings
    };
  }
}