import 'package:flutter/material.dart';
import 'package:graduation_project2/services/models/FeedBack.dart';

import 'Product.dart';

class Pharmacy {
  final int id;
  final String name;
  final String phoneNumber;
  final String address; 
  final String workingHours;
  final double latitude;
  final double longitude;
  final String description;
  final double rating;
  final List<FeedBack> feedbacks;
  final List<int> productIds;
  final List<Product> products;

  Pharmacy({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.address,
    required this.workingHours,
    required this.latitude,
    required this.longitude,
    required this.description,
    required this.rating,
    required this.feedbacks,
    required this.productIds,
    required this.products,
  });

  factory Pharmacy.fromJson(Map<String, dynamic> json) {
    var productList = <Product>[];
    if (json['products'] != null) {
      productList = (json['products'] as List).map((i) => Product.fromJson(i)).toList();
    }
    List<int> productIds = List<int>.from(json['productIds'] ?? []);
     var feedbackList = <FeedBack>[];
    if (json['feedbacks'] != null) {
      feedbackList = (json['feedbacks'] as List).map((i) => FeedBack.fromJson(i)).toList();
    }

    return Pharmacy(
      id: json['id'],
      name: json['name'],
      phoneNumber: json['phoneNumber'],
      address: json['address'],
      workingHours: json['workingHours'],
      latitude: json['latitude'].toDouble(),
      longitude: json['longitude'].toDouble(),
      description: json['description'],
      rating: json['rating'] is int ? (json['rating'] as int).toDouble() : json['rating'],
      feedbacks:feedbackList,
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
      'feedbacks': feedbacks.map((feedback) => feedback.toJson()).toList(),
      'productIds':productIds.cast<int>().toList(),
      'products': products.map((product) => product.toJson()).toList(),
    };
  }
}