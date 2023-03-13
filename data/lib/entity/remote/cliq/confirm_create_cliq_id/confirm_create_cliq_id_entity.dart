import 'package:domain/model/cliq/create_cliq_id/confirm_create_cliq_id.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'confirm_create_cliq_id_entity.g.dart';

@JsonSerializable()
class ConfirmCreateCliqIdEntity
    implements BaseLayerDataTransformer<ConfirmCreateCliqIdEntity, ConfirmCreateCliqId> {
  @JsonKey(name: "transferType", defaultValue: '')
  final String? transferType;
  @JsonKey(name: "cliqType", defaultValue: '')
  final String? cliqType;
  @JsonKey(name: "iban", defaultValue: '')
  final String? iban;
  @JsonKey(name: "accountNo", defaultValue: '')
  final String? accountNo;
  @JsonKey(name: "mobileNo", defaultValue: '')
  final String? mobileNo;
  @JsonKey(name: "alias", defaultValue: '')
  final String? alias;
  @JsonKey(name: "bankName", defaultValue: '')
  final String? bankName;
  @JsonKey(name: "bankAddress", defaultValue: '')
  final String? bankAddress;
  @JsonKey(name: "bankCountry", defaultValue: '')
  final String? bankCountry;
  @JsonKey(name: "swiftCode", defaultValue: '')
  final String? swiftCode;
  @JsonKey(name: "accountTittle", defaultValue: '')
  final String? accountTittle;
  @JsonKey(name: "accountType", defaultValue: '')
  final String? accountType;
  @JsonKey(name: "country", defaultValue: '')
  final String? country;
  @JsonKey(name: "city", defaultValue: '')
  final String? city;
  @JsonKey(name: "stateProvinceRegion", defaultValue: '')
  final String? stateProvinceRegion;
  @JsonKey(name: "address", defaultValue: '')
  final String? address;
  @JsonKey(name: "currencyCode", defaultValue: '')
  final String? currencyCode;

  ConfirmCreateCliqIdEntity(
      {this.transferType,
      this.cliqType,
      this.iban,
      this.accountNo,
      this.mobileNo,
      this.alias,
      this.bankName,
      this.bankAddress,
      this.bankCountry,
      this.swiftCode,
      this.accountTittle,
      this.accountType,
      this.country,
      this.city,
      this.stateProvinceRegion,
      this.address,
      this.currencyCode});

  Map<String, dynamic> toJson() => _$ConfirmCreateCliqIdEntityToJson(this);

  factory ConfirmCreateCliqIdEntity.fromJson(Map<String, dynamic> json) =>
      _$ConfirmCreateCliqIdEntityFromJson(json);

  @override
  ConfirmCreateCliqIdEntity restore(ConfirmCreateCliqId data) {
    throw UnimplementedError();
  }

  @override
  ConfirmCreateCliqId transform() {
    return ConfirmCreateCliqId(
        transferType: this.transferType,
        cliqType: this.cliqType,
        iban: this.iban,
        accountNo: this.accountNo,
        mobileNo: this.mobileNo,
        alias: this.alias,
        bankName: this.bankName,
        bankAddress: this.bankAddress,
        bankCountry: this.bankCountry,
        swiftCode: this.swiftCode,
        accountTittle: this.accountTittle,
        accountType: this.accountType,
        country: this.country,
        city: this.city,
        stateProvinceRegion: this.stateProvinceRegion,
        address: this.address,
        currencyCode: this.currencyCode);
  }
}
