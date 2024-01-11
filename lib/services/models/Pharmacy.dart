import 'Product.dart';

class Pharmacy {
  final int id;
  final String name;
  final String phoneNumber;
  final String address; 
  final double latitude;
  final double longitude;
  final String description;
  final double rating;
  final List<int> productIds;
  final List<Product> products;

  Pharmacy({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.description,
    required this.rating,
    required this.productIds,
    required this.products,
  });

  factory Pharmacy.fromJson(Map<String, dynamic> json) {
    var productList = <Product>[];
    if (json['products'] != null) {
      productList = (json['products'] as List).map((i) => Product.fromJson(i)).toList();
    }
    List<int> productIds = List<int>.from(json['productIds'] ?? []);

    return Pharmacy(
      id: json['id'],
      name: json['name'],
      phoneNumber: json['phoneNumber'],
      address: json['address'],
      latitude: json['latitude'].toDouble(),
      longitude: json['longitude'].toDouble(),
      description: json['description'],
     rating: json['rating'] is int ? (json['rating'] as int).toDouble() : json['rating'],
      productIds: productIds,
      products: productList,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phoneNumber': phoneNumber,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'description': description,
      'rating': rating,
      'products': products.map((product) => product.toJson()).toList(),
    };
  }
}