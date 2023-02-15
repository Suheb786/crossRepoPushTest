import 'package:domain/model/cliq/get_account_by_customer_id/get_account_by_customer_id.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_account_by_customer_id_entity.g.dart';

@JsonSerializable()
class GetAccountByCustomerIdEntity
    extends BaseLayerDataTransformer<GetAccountByCustomerIdEntity, GetAccountByCustomerId> {
  @JsonKey(
    name: "recordId",
    defaultValue: "",
  )
  final String? recordId;

  @JsonKey(
    name: "acciban",
    defaultValue: "",
  )
  final String? acciban;

  @JsonKey(
    name: "bic",
    defaultValue: "",
  )
  final String? bic;

  @JsonKey(
    name: "openingDate",
    defaultValue: "",
  )
  final dynamic openingDate;

  @JsonKey(
    name: "closingDate",
    defaultValue: "",
  )
  final dynamic closingDate;

  @JsonKey(
    name: "currency",
    defaultValue: "",
  )
  final String? currency;

  @JsonKey(
    name: "type",
    defaultValue: "",
  )
  final String? type;

  @JsonKey(
    name: "accountType",
    defaultValue: "",
  )
  final String? accountType;

  @JsonKey(
    name: "accountNumber",
    defaultValue: "",
  )
  final String? accountNumber;

  GetAccountByCustomerIdEntity(
      {this.recordId,
      this.acciban,
      this.bic,
      this.openingDate,
      this.closingDate,
      this.currency,
      this.type,
      this.accountType,
      this.accountNumber});

  factory GetAccountByCustomerIdEntity.fromJson(Map<String, dynamic> json) =>
      _$GetAccountByCustomerIdEntityFromJson(json);

  Map<String, dynamic> toJson() => _$GetAccountByCustomerIdEntityToJson(this);

  @override
  GetAccountByCustomerIdEntity restore(GetAccountByCustomerId data) {
    return super.restore(data);
  }

  @override
  GetAccountByCustomerId transform() {
    return GetAccountByCustomerId(
        recordId: this.recordId,
        acciban: this.acciban,
        bic: this.bic,
        openingDate: this.openingDate,
        closingDate: this.closingDate,
        currency: this.currency,
        type: this.type,
        accountType: this.accountType,
        accountNumber: this.accountNumber);
  }
}
