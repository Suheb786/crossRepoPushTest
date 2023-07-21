import 'package:domain/model/e_voucher/voucher_detail.dart';

class VouchersByDate {
  String date;
  List<VoucherDetail> data;

  VouchersByDate({
    required this.date,
    required this.data,
  });
}
