import 'package:domain/model/bank_smart/customer_account_details.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'account_details_entity.g.dart';

@JsonSerializable()
class AccountDetailsEntity extends BaseLayerDataTransformer<
    AccountDetailsEntity, CustomerAccountDetails> {
  @JsonKey(name: "createBy")
  final String? createBy;
  @JsonKey(name: "ourBranchID")
  final String? ourBranchID;
  @JsonKey(name: "clientID")
  final dynamic? clientID;
  @JsonKey(name: "productID")
  final String? productID;
  @JsonKey(name: "name")
  final String? name;
  @JsonKey(name: "address")
  final String? address;
  @JsonKey(name: "countryID")
  final String? countryID;
  @JsonKey(name: "stateID")
  final String? stateID;
  @JsonKey(name: "cityID")
  final String? cityID;
  @JsonKey(name: "statementFrequency")
  final String? statementFrequency;
  @JsonKey(name: "holdMail")
  final int? holdMail;
  @JsonKey(name: "zakatExemption")
  final int? zakatExemption;
  @JsonKey(name: "introducerAccountNo")
  final String? introducerAccountNo;
  @JsonKey(name: "introducedBy")
  final String? introducedBy;
  @JsonKey(name: "introducerAddress")
  final String? introducerAddress;
  @JsonKey(name: "introducerCityID")
  final String? introducerCityID;
  @JsonKey(name: "introducerStateID")
  final String? introducerStateID;
  @JsonKey(name: "introducerCountryID")
  final String? introducerCountryID;
  @JsonKey(name: "modeOfOperation")
  final String? modeOfOperation;
  @JsonKey(name: "reminder")
  final String? reminder;
  @JsonKey(name: "notes")
  final String? notes;
  @JsonKey(name: "natureID")
  final String? natureID;
  @JsonKey(name: "relationshipCode")
  final String? relationshipCode;
  @JsonKey(name: "dontAllowCreditTran")
  final int? dontAllowCreditTran;
  @JsonKey(name: "dontAllowDebitTran")
  final int? dontAllowDebitTran;
  @JsonKey(name: "creditNeedsSupervision")
  final int? creditNeedsSupervision;
  @JsonKey(name: "debitNeedsSupervision")
  final int? debitNeedsSupervision;
  @JsonKey(name: "notServiceCharges")
  final int? notServiceCharges;
  @JsonKey(name: "notStopPaymentCharges")
  final int? notStopPaymentCharges;
  @JsonKey(name: "notChequeBookCharges")
  final int? notChequeBookCharges;
  @JsonKey(name: "turnOver")
  final String? turnOver;
  @JsonKey(name: "noOfDrTrx")
  final dynamic? noOfDrTrx;
  @JsonKey(name: "noOfCrTrx")
  final dynamic? noOfCrTrx;
  @JsonKey(name: "drThresholdLimit")
  final dynamic? drThresholdLimit;
  @JsonKey(name: "crThresholdLimit")
  final dynamic? crThresholdLimit;
  @JsonKey(name: "productCash")
  final int? productCash;
  @JsonKey(name: "productClearing")
  final int? productClearing;
  @JsonKey(name: "productCollection")
  final int? productCollection;
  @JsonKey(name: "productRemittance")
  final int? productRemittance;
  @JsonKey(name: "productCross")
  final int? productCross;
  @JsonKey(name: "productOthers")
  final int? productOthers;
  @JsonKey(name: "productOthersDesc")
  final String? productOthersDesc;
  @JsonKey(name: "idType")
  final dynamic? idType;

  factory AccountDetailsEntity.fromJson(Map<String, dynamic> json) =>
      _$AccountDetailsEntityFromJson(json);

  AccountDetailsEntity(
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
      this.holdMail: 0,
      this.zakatExemption: 0,
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
      this.dontAllowDebitTran: 0,
      this.dontAllowCreditTran: 0,
      this.creditNeedsSupervision: 0,
      this.debitNeedsSupervision: 0,
      this.notServiceCharges: 0,
      this.notStopPaymentCharges: 0,
      this.notChequeBookCharges: 0,
      this.turnOver,
      this.noOfDrTrx: 0,
      this.noOfCrTrx: 0,
      this.drThresholdLimit: 0,
      this.crThresholdLimit: 0,
      this.productCash: 0,
      this.productClearing: 0,
      this.productCollection: 0,
      this.productRemittance: 0,
      this.productCross: 0,
      this.productOthers: 0,
      this.productOthersDesc,
      this.idType});

  Map<String, dynamic> toJson() => _$AccountDetailsEntityToJson(this);

  @override
  CustomerAccountDetails transform() {
    return CustomerAccountDetails(
        createBy: this.createBy,
        ourBranchID: this.ourBranchID,
        clientID: this.clientID,
        productID: this.productID,
        name: this.name,
        address: this.address,
        countryID: this.countryID,
        stateID: this.stateID,
        cityID: this.cityID,
        statementFrequency: this.statementFrequency,
        holdMail: this.holdMail,
        zakatExemption: this.zakatExemption,
        introducerAccountNo: this.introducerAccountNo,
        introducedBy: this.introducedBy,
        introducerAddress: this.introducerAddress,
        introducerCityID: this.introducerCityID,
        introducerStateID: this.introducerStateID,
        introducerCountryID: this.introducerCountryID,
        modeOfOperation: this.modeOfOperation,
        reminder: this.reminder,
        notes: this.notes,
        natureID: this.natureID,
        relationshipCode: this.relationshipCode,
        dontAllowCreditTran: this.dontAllowCreditTran,
        dontAllowDebitTran: this.dontAllowDebitTran,
        creditNeedsSupervision: this.creditNeedsSupervision,
        debitNeedsSupervision: this.debitNeedsSupervision,
        notServiceCharges: this.notServiceCharges,
        notStopPaymentCharges: this.notStopPaymentCharges,
        notChequeBookCharges: this.notChequeBookCharges,
        turnOver: this.turnOver,
        noOfDrTrx: this.noOfDrTrx,
        noOfCrTrx: this.noOfCrTrx,
        drThresholdLimit: this.drThresholdLimit,
        crThresholdLimit: this.crThresholdLimit,
        productCash: this.productCash,
        productClearing: this.productClearing,
        productCollection: this.productCollection,
        productRemittance: this.productRemittance,
        productCross: this.productCross,
        productOthers: this.productOthers,
        productOthersDesc: this.productOthersDesc,
        idType: this.idType);
  }

  @override
  AccountDetailsEntity restore(CustomerAccountDetails data) {
    return AccountDetailsEntity(
        createBy: data.createBy,
        ourBranchID: data.ourBranchID,
        clientID: data.clientID,
        productID: data.productID,
        name: data.name,
        address: data.address,
        countryID: data.countryID,
        stateID: data.stateID,
        cityID: data.cityID,
        statementFrequency: data.statementFrequency,
        holdMail: data.holdMail,
        zakatExemption: data.zakatExemption,
        introducerAccountNo: data.introducerAccountNo,
        introducedBy: data.introducedBy,
        introducerAddress: data.introducerAddress,
        introducerCityID: data.introducerCityID,
        introducerStateID: data.introducerStateID,
        introducerCountryID: data.introducerCountryID,
        modeOfOperation: data.modeOfOperation,
        reminder: data.reminder,
        notes: data.notes,
        natureID: data.natureID,
        relationshipCode: data.relationshipCode,
        dontAllowDebitTran: data.dontAllowDebitTran,
        dontAllowCreditTran: data.dontAllowCreditTran,
        creditNeedsSupervision: data.creditNeedsSupervision,
        debitNeedsSupervision: data.debitNeedsSupervision,
        notServiceCharges: data.notServiceCharges,
        notStopPaymentCharges: data.notStopPaymentCharges,
        notChequeBookCharges: data.notChequeBookCharges,
        turnOver: data.turnOver,
        noOfDrTrx: data.noOfDrTrx,
        noOfCrTrx: data.noOfCrTrx,
        drThresholdLimit: data.drThresholdLimit,
        crThresholdLimit: data.crThresholdLimit,
        productCash: data.productCash,
        productClearing: data.productClearing,
        productCollection: data.productCollection,
        productRemittance: data.productRemittance,
        productCross: data.productCross,
        productOthers: data.productOthers,
        productOthersDesc: data.productOthersDesc,
        idType: data.idType);
  }
}
