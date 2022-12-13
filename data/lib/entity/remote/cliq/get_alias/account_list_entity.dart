import 'package:domain/model/cliq/getAlias/account_list.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'account_list_entity.g.dart';

@JsonSerializable()
class AccountListEntity extends BaseLayerDataTransformer<AccountListEntity, AccountList> {
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
  final String? openingDate;
  @JsonKey(
    name: "closingDate",
    defaultValue: "",
  )
  final String? closingDate;
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
    name: "isDefault",
    defaultValue: false,
  )
  final bool? isDefault;

  AccountListEntity({
    required this.recordId,
    required this.acciban,
    required this.bic,
    required this.openingDate,
    required this.closingDate,
    required this.currency,
    required this.type,
    required this.isDefault,
  });

  factory AccountListEntity.fromJson(Map<String, dynamic> json) => _$AccountListEntityFromJson(json);

  Map<String, dynamic> toJson() => _$AccountListEntityToJson(this);

  @override
  AccountListEntity restore(AccountList data) {
    return super.restore(data);
  }

  @override
  AccountList transform() {
    return AccountList(
        acciban: this.acciban,
        bic: this.bic,
        closingDate: this.closingDate,
        currency: this.currency,
        openingDate: this.openingDate,
        recordId: this.recordId,
        type: this.type,
        isDefault: this.isDefault);
  }
}
