import 'Pharmacy.dart';
import 'User.dart';
class FeedBack {
  final bool status; // Note: Ensure correct spelling here
  final String text;
  final String title;
  final double rating; // 'Ratting' from backend should be 'rating' in Dart
  final int userId;
  final int pharmacyId;
  final User user; // Assuming you have a User class defined
  final Pharmacy pharmacy; // Assuming you have a Pharmacy class defined

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
      status: json['Statues'] ?? false, // Default to false if not provided
      text: json['Text'] ?? '',
      title: json['Title'] ?? '',
      rating: (json['Ratting'] as num?)?.toDouble() ?? 0.0, // Convert to double
      userId: json['UserId'] ?? 0,
      pharmacyId: json['PharmacyId'] ?? 0,
      user: User.fromJson(json['Users'] ?? {}), // Handle null case
      pharmacy: Pharmacy.fromJson(json['Pharmacy'] ?? {}), // Handle null case
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