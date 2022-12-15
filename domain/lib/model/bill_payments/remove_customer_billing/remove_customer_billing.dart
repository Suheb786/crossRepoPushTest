import 'package:domain/model/bill_payments/remove_customer_billing/remove_customer_billing_content.dart';

class RemoveCustomerBilling {
  final RemoveCustomerBillingContent? content;
  final String? requestDateTime;
  final String? logId;

  RemoveCustomerBilling({
    this.content,
    this.requestDateTime,
    this.logId,
  });
}
