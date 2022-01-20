import 'package:domain/model/payment/payment_activity_data.dart';

class PaymentActivityContent {
  PaymentActivityContent({
    this.rtpDate,
    this.data,
  });

  DateTime? rtpDate;
  List<PaymentActivityData>? data;
}
