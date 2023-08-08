import 'package:domain/model/e_voucher/voucher_line_item.dart';

class VoucherDetail {
  String id;
  String customerName;
  String deliveryChannel;
  String cardImage;
  String emailAddress;
  String referenceNo;
  String creationDate;
  List<VoucherLineItem> lineItems;

  VoucherDetail({
    required this.id,
    required this.customerName,
    required this.deliveryChannel,
    required this.cardImage,
    required this.emailAddress,
    required this.referenceNo,
    required this.creationDate,
    required this.lineItems,
  });
}
