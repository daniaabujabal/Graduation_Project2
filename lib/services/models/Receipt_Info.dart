import 'Receipts_Products.dart';

class ReceiptInfo {
  final int id;
  final DateTime date;
  final String pharmacistName;
  final double totalPrice;
  final List<ReceiptsProducts> receiptsProducts;

  ReceiptInfo({
    required this.id,
    required this.date,
    required this.pharmacistName,
    required this.totalPrice,
    required this.receiptsProducts,
  });

}
