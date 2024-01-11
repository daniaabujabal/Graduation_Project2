import 'FeedBack.dart'; 
import 'User_Product.dart'; // And for Product

class User {
  final int id;
  final String userName;
  final String password;
  final String phoneNumber;
  final double latitude;
  final double longitude;
  final List<FeedBack> feedBacks; 
  final List<UserProduct> userProducts;

  User({
    required this.id,
    required this.userName,
    required this.password,
    required this.phoneNumber,
    required this.latitude,
    required this.longitude,
    required this.feedBacks,
    required this.userProducts,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      userName: json['userName'],
      password: json['password'],
      phoneNumber: json['phoneNumber'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      feedBacks: (json['feedBacks'] as List).map((i) => FeedBack.fromJson(i)).toList(),
      userProducts: (json['userProducts'] as List).map((i) => UserProduct.fromJson(i)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userName': userName,
      'password': password,
      'phoneNumber': phoneNumber,
      'latitude': latitude,
      'longitude': longitude,
      'feedBacks': feedBacks.map((i) => i.toJson()).toList(),
      'userProducts': userProducts.map((i) => i.toJson()).toList(),
    };
  }
}