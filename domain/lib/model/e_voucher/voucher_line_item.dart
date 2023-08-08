import 'package:domain/constants/enum/evoucher_history_status_enum.dart';

class VoucherLineItem {
  int? lineNumber;
  String? cardItemId;
  num? value;
  EvoucherHistoryStatusEnum? status;
  String? claimURL;
  String? cardItemName;
  String? currency;

  VoucherLineItem({
    required this.lineNumber,
    required this.cardItemId,
    required this.value,
    required this.status,
    required this.claimURL,
    required this.cardItemName,
    required this.currency,
  });
}
