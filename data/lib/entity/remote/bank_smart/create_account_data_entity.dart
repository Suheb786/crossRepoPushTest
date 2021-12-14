import 'package:domain/model/bank_smart/create_account_data.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_account_data_entity.g.dart';

@JsonSerializable()
class CreateAccountDataEntity
    implements
        BaseLayerDataTransformer<CreateAccountDataEntity, CreateAccountData> {
  @JsonKey(name: "accountDate")
  final dynamic accountDate;

  @JsonKey(name: "name")
  final dynamic name;
  @JsonKey(name: "accountNumber")
  final dynamic accountNumber;
  @JsonKey(name: "iban")
  final dynamic iban;
  @JsonKey(name: "cif")
  final dynamic cif;
  @JsonKey(name: "promoCode")
  final dynamic promoCode;
  @JsonKey(name: "balance")
  final dynamic balance;
  @JsonKey(name: "currencyCode")
  final dynamic currencyCode;
  @JsonKey(name: "zPoints")
  final dynamic zPoints;
  @JsonKey(name: "dailyLimitLeft")
  final dynamic dailyLimitLeft;
  @JsonKey(name: "dailyTransferLimit")
  final dynamic dailyTransferLimit;
  @JsonKey(name: "bankName")
  final dynamic bankName;
  @JsonKey(name: "countryName")
  final dynamic countryName;
  @JsonKey(name: "swiftCode")
  final dynamic swiftCode;
  @JsonKey(name: "cardNumber")
  final dynamic cardNumber;

  CreateAccountDataEntity(
      {this.accountDate,
      this.name,
      this.accountNumber,
      this.iban,
      this.cif,
      this.promoCode,
      this.balance,
      this.currencyCode,
      this.zPoints,
      this.dailyLimitLeft,
      this.dailyTransferLimit,
      this.bankName,
      this.countryName,
      this.swiftCode,
      this.cardNumber});

  factory CreateAccountDataEntity.fromJson(Map<String, dynamic> json) =>
      _$CreateAccountDataEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CreateAccountDataEntityToJson(this);

  @override
  CreateAccountDataEntity restore(CreateAccountData response) {
    return CreateAccountDataEntity();
  }

  @override
  CreateAccountData transform() {
    return CreateAccountData(
        countryName: this.countryName,
        accountNumber: this.accountNumber,
        name: this.name,
        accountDate: this.accountDate,
        balance: this.balance,
        bankName: this.bankName,
        cardNumber: this.cardNumber,
        cif: this.cif,
        currencyCode: this.currencyCode,
        dailyLimitLeft: this.dailyLimitLeft,
        dailyTransferLimit: this.dailyTransferLimit,
        iban: this.iban,
        promoCode: this.promoCode,
        swiftCode: this.swiftCode,
        zPoints: this.zPoints);
  }
}
