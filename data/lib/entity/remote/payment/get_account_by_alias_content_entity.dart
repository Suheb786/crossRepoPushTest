import 'package:domain/model/payment/get_account_by_alias_content.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part "get_account_by_alias_content_entity.g.dart";

@JsonSerializable()
class GetAccountByAliasContentEntity
    implements
        BaseLayerDataTransformer<GetAccountByAliasContentEntity,
            GetAccountByAliasContent> {
  @JsonKey(name: "acciban")
  final String? acciban;
  @JsonKey(name: "bic")
  final String? bic;
  @JsonKey(name: "currency")
  final String? currency;
  @JsonKey(name: "type")
  final String? type;
  @JsonKey(name: "name")
  final String? name;
  @JsonKey(name: "surname")
  final String? surname;
  @JsonKey(name: "nickName")
  final String? nickName;
  @JsonKey(name: "addressCity")
  final String? addressCity;
  @JsonKey(name: "addressCountry")
  final String? addressCountry;
  @JsonKey(name: "addressSPR")
  final String? addressSPR;
  @JsonKey(name: "address")
  final String? address;
  @JsonKey(name: "detCustomerType")
  final String? detCustomerType;

  GetAccountByAliasContentEntity(
      {this.acciban,
      this.bic,
      this.currency,
      this.type,
      this.name,
      this.surname,
      this.nickName,
      this.addressCity,
      this.addressCountry,
      this.addressSPR,
      this.address,
      this.detCustomerType});

  factory GetAccountByAliasContentEntity.fromJson(Map<String, dynamic> json) =>
      _$GetAccountByAliasContentEntityFromJson(json);

  Map<String, dynamic> toJson() => _$GetAccountByAliasContentEntityToJson(this);

  @override
  GetAccountByAliasContentEntity restore(GetAccountByAliasContent response) {
    return GetAccountByAliasContentEntity();
  }

  @override
  GetAccountByAliasContent transform() {
    return GetAccountByAliasContent(
        acciban: this.acciban,
        bic: this.bic,
        currency: this.currency,
        name: this.name,
        type: this.type,
        address: this.address,
        addressCity: this.addressCity,
        addressCountry: this.addressCountry,
        addressSpr: this.addressSPR,
        detCustomerType: this.detCustomerType,
        nickName: this.nickName,
        surname: this.surname);
  }
}
