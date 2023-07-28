class PlaceOrder {
  String id;
  String customerName;
  String deliveryChannel;
  String? emailAddress;
  String? smsMobileNumber;
  String referenceNo;
  String creationDate;
  String placementDate;
  List<LineItem> lineItems;
  PlaceOrder({
    required this.id,
    required this.customerName,
    required this.deliveryChannel,
    required this.emailAddress,
    required this.smsMobileNumber,
    required this.referenceNo,
    required this.creationDate,
    required this.placementDate,
    required this.lineItems,
  });
}

class LineItem {
  int lineNumber;
  String cardItemId;
  String? cardItemName;
  int value;
  String currency;
  String certificateGenerationKey;
  String status;
  String claimURL;
  String settlementCurrency;
  double exchangeRate;
  double settlementPrice;
  double netPrice;

  LineItem({
    required this.lineNumber,
    required this.cardItemId,
    required this.cardItemName,
    required this.value,
    required this.currency,
    required this.certificateGenerationKey,
    required this.status,
    required this.claimURL,
    required this.settlementCurrency,
    required this.exchangeRate,
    required this.settlementPrice,
    required this.netPrice,
  });
}
