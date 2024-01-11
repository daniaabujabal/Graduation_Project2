import 'Product.dart';
import 'Receipt_Info.dart';

class ReceiptsProducts {
  final int id;
  final int receiptNumber;
  final int productId;
  final ReceiptInfo receipt;
  final Product productInfo;
  final int quantity;

  ReceiptsProducts({
    required this.id,
    required this.receiptNumber,
    required this.productId,
    required this.receipt,
    required this.productInfo,
    required this.quantity,
  });
}