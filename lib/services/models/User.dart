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
    // Assuming 'json['feedBacks']' is a List of Map<String, dynamic> that represents feedbacks.
    List<FeedBack> feedbacksList = (json['feedBacks'] as List<dynamic>?)
            ?.map((e) => FeedBack.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [];

    List<UserProduct> userProductsList = json['userProducts'] != null
        ? (json['userProducts'] as List)
            .map((i) => UserProduct.fromJson(i))
            .toList()
        : []; // Empty list if null

    return User(
      id: json['id'] ?? 0, // Default to 0 if id is null
      userName: json['userName'] ??
          '', // Default to an empty string if userName is null
      password: json['password'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      latitude: (json['latitude'] as num?)?.toDouble() ??
          0.0, // Default to 0.0 if latitude is null
      longitude: (json['longitude'] as num?)?.toDouble() ??
          0.0, // Default to 0.0 if longitude is null
      feedBacks: feedbacksList,
      userProducts: userProductsList,
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
