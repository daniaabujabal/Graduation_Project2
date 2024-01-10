
class Product {
  final int id;
  final String tradeName;
  final String scientificName;
  final String number;
  final String provider;
  final String localAgent;
  final String country;
  final double publicPrice;
  final double publicPriceWTax;
  final int barCode;
  final int quantity;
  final String atcCode;
  final int amount;
  final double privatePrice;
  final DateTime expireDate;
  final String description;
  final double discount;
  final int userId;
  final List<int> pharmacyIds;

  Product({
    required this.id,
    required this.tradeName,
    required this.scientificName,
    required this.number,
    required this.provider,
    required this.localAgent,
    required this.country,
    required this.publicPrice,
    required this.publicPriceWTax,
    required this.barCode,
    required this.quantity,
    required this.atcCode,
    required this.amount,
    required this.privatePrice,
    required this.expireDate,
    required this.description,
    required this.discount,
    required this.userId,
    required this.pharmacyIds,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      tradeName: json['tradeName'],
      scientificName: json['scientificName'],
      number: json['number'],
      provider: json['provider'],
      localAgent: json['localAgent'],
      country: json['country'],
      publicPrice: json['publicPrice'].toDouble(),
      publicPriceWTax: json['publicPriceWTax'].toDouble(),
      barCode: json['barCode'],
      quantity: json['quantity'],
      atcCode: json['atcCode'],
      amount: json['amount'],
      privatePrice: json['privatePrice'].toDouble(),
      expireDate: DateTime.parse(json['expireDate']),
      description: json['description'],
      discount: json['discount'].toDouble(),
      userId: json['userId'],
      pharmacyIds: List<int>.from(json['pharmacyIds']),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'tradeName': tradeName,
      'scientificName': scientificName,
      'number': number,
      'provider': provider,
      'localAgent': localAgent,
      'country': country,
      'publicPrice': publicPrice,
      'publicPriceWTax': publicPriceWTax,
      'barCode': barCode,
      'quantity': quantity,
      'atcCode': atcCode,
      'amount': amount,
      'privatePrice': privatePrice,
      'expireDate': expireDate.toIso8601String(),
      'description': description,
      'discount': discount,
      'userId': userId,
      'pharmacyIds': pharmacyIds,
    };
  }
}