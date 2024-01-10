import 'Product.dart';

class Receipt {
  final int id;
  final String pharmacistName;
  final int receiptNum;
  final int numOfProducts;
  final List<Product> products;
  final double totalPrice;

  Receipt({
    required this.id,
    required this.pharmacistName,
    required this.receiptNum,
    required this.numOfProducts,
    required this.products,
    required this.totalPrice,
  });

}
