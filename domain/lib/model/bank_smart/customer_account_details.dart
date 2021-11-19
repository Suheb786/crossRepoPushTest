class CustomerAccountDetails {
  final String? createBy;
  final String? ourBranchID;
  final String? clientID;
  final String? productID;
  final String? name;
  final String? address;
  final String? countryID;
  final String? stateID;
  final String? cityID;
  final String? statementFrequency;
  final int? holdMail;
  final int? zakatExemption;
  final String? introducerAccountNo;
  final String? introducedBy;
  final String? introducerAddress;
  final String? introducerCityID;
  final String? introducerStateID;
  final String? introducerCountryID;
  final String? modeOfOperation;
  final String? reminder;
  final String? notes;
  final String? natureID;
  final String? relationshipCode;
  final int? allowCreditTransaction;
  final int? allowDebitTransaction;
  final int? creditNeedsSupervision;
  final int? debitNeedsSupervision;
  final int? notServiceCharges;
  final int? notStopPaymentCharges;
  final int? notChequeBookCharges;
  final String? turnOver;
  final int? noOfDrTrx;
  final int? noOfCrTrx;
  final double? drThresholdLimit;
  final double? crThresholdLimit;
  final int? productCash;
  final int? productClearing;
  final int? productCollection;
  final int? productRemittance;
  final int? productCross;
  final int? productOthers;
  final String? productOthersDesc;

  CustomerAccountDetails(
      {this.createBy,
      this.ourBranchID,
      this.clientID,
      this.productID,
      this.name,
      this.address,
      this.countryID,
      this.stateID,
      this.cityID,
      this.statementFrequency,
      this.holdMail,
      this.zakatExemption,
      this.introducerAccountNo,
      this.introducedBy,
      this.introducerAddress,
      this.introducerCityID,
      this.introducerStateID,
      this.introducerCountryID,
      this.modeOfOperation,
      this.reminder,
      this.notes,
      this.natureID,
      this.relationshipCode,
      this.allowCreditTransaction,
      this.allowDebitTransaction,
      this.creditNeedsSupervision,
      this.debitNeedsSupervision,
      this.notServiceCharges,
      this.notStopPaymentCharges,
      this.notChequeBookCharges,
      this.turnOver,
      this.noOfDrTrx,
      this.noOfCrTrx,
      this.drThresholdLimit,
      this.crThresholdLimit,
      this.productCash,
      this.productClearing,
      this.productCollection,
      this.productRemittance,
      this.productCross,
      this.productOthers,
      this.productOthersDesc});
}
