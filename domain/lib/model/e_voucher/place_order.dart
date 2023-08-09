class PlaceOrder {
  String? id;
  String? customerName;
  String? deliveryChannel;
  String? emailAddress;
  String? smsMobileNumber;
  String? referenceNo;
  String? creationDate;
  String? placementDate;
  List<LineItem>? lineItems;

  PlaceOrder({
    this.id = '',
    this.customerName = '',
    this.deliveryChannel = '',
    this.emailAddress = '',
    this.smsMobileNumber = '',
    this.referenceNo = '',
    this.creationDate = '',
    this.placementDate = '',
    this.lineItems,
  });
}

class LineItem {
  int? lineNumber;
  String? cardItemId;
  String? cardItemName;
  double? value;
  String? currency;
  String? certificateGenerationKey;
  String? status;
  String? claimURL;
  String? settlementCurrency;
  String? exchangeRate;
  String? settlementPrice;
  String? netPrice;

  LineItem({
    this.lineNumber = 0,
    this.cardItemId = '',
    this.cardItemName = '',
    this.value = 0.0,
    this.currency = '',
    this.certificateGenerationKey = '',
    this.status = '',
    this.claimURL = '',
    this.settlementCurrency = '',
    this.exchangeRate = "0.0",
    this.settlementPrice = "0.0",
    this.netPrice = "0.0",
  });
}
