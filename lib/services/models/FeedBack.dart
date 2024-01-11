import 'Pharmacy.dart';
import 'User.dart';
class FeedBack {
  final bool status; 
  final String text;
  final String title;
  final double rating; 
  final int userId;
  final int pharmacyId;
  final User user;
  final Pharmacy pharmacy;

  FeedBack({
    required this.status,
    required this.text,
    required this.title,
    required this.rating,
    required this.userId,
    required this.pharmacyId,
    required this.user,
    required this.pharmacy,
  });

  factory FeedBack.fromJson(Map<String, dynamic> json) {
    return FeedBack(
      status: json['Statues'],
      text: json['Text'],
      title: json['Title'],
      rating: json['Ratting'].toDouble(),
      userId: json['UserId'],
      pharmacyId: json['PharmacyId'],
      user: User.fromJson(json['Users']),
      pharmacy: Pharmacy.fromJson(json['Pharmacy']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Statues': status,
      'Text': text,
      'Title': title,
      'Ratting': rating,
      'UserId': userId,
      'PharmacyId': pharmacyId,
      'Users': user.toJson(),
      'Pharmacy': pharmacy.toJson(),
    };
  }
}
