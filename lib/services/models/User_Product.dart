import 'Product.dart';
import 'User.dart';

class UserProduct {
  final int userId;
  final int productId;
  final User user;
  final Product product;
  final DateTime viewedAt;

  UserProduct({
    required this.userId,
    required this.productId,
    required this.user,
    required this.product,
    required this.viewedAt,
  });

  factory UserProduct.fromJson(Map<String, dynamic> json) {
    return UserProduct(
      userId: json['userId'],
      productId: json['productId'],
      user: User.fromJson(json['user']),
      product: Product.fromJson(json['product']),
      viewedAt: DateTime.parse(json['viewedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'productId': productId,
      'user': user.toJson(),
      'product': product.toJson(),
      'viewedAt': viewedAt.toIso8601String(),
    };
  }
}