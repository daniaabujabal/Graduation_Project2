import 'FeedBack.dart';
import 'Product.dart';
import 'Pharmacy.dart';

class PharmacyProduct {
  final double? publicPrice;
  final double? quantity;
  final int? amount;
  final double? privatePrice;
  final int pharmacyId;
  final Pharmacy? pharmacy;
  final int productId;
  final Product? product;

  PharmacyProduct({
    this.publicPrice,
    this.quantity,
    this.amount,
    this.privatePrice,
    required this.pharmacyId,
    this.pharmacy,
    required this.productId,
    this.product,
  });

  factory PharmacyProduct.fromJson(Map<String, dynamic> json) {
    // Use the null-aware operator (??) to provide a default value
    return PharmacyProduct(
      publicPrice: json['PublicPrice'] as double? ?? 0.0,
      quantity: json['Quantity'] as double? ?? 0.0,
      amount: json['Amount'] as int? ?? 0,
      privatePrice: json['PrivatePrice'] as double? ?? 0.0,
      pharmacyId: json['PharmacyId'] as int? ?? 0,
      pharmacy: json['Pharmacy'] != null ? Pharmacy.fromJson(json['Pharmacy']) : null,
      productId: json['ProductId'] as int? ?? 0,
      product: json['Product'] != null ? Product.fromJson(json['Product']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    // Provide a default empty string for serialization if the value is null
    return {
      'PublicPrice': publicPrice?.toString() ?? '',
      'Quantity': quantity?.toString() ?? '',
      'Amount': amount?.toString() ?? '',
      'PrivatePrice': privatePrice?.toString() ?? '',
      'PharmacyId': pharmacyId.toString(), // Assuming pharmacyId cannot be null
      'Pharmacy': pharmacy?.toJson() ?? '',
      'ProductId': productId.toString(), // Assuming productId cannot be null
      'Product': product?.toJson() ?? '',
    };
  }
}
