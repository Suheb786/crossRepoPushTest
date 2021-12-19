import 'package:data/entity/remote/bank_smart/account_details_entity.dart';
import 'package:data/entity/remote/bank_smart/customer_details_entity.dart';
import 'package:domain/model/bank_smart/get_account_content.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_account_content_entity.g.dart';

@JsonSerializable()
class GetAccountContentEntity
    implements
        BaseLayerDataTransformer<GetAccountContentEntity, GetAccountContent> {
  @JsonKey(name: "account")
  final AccountDetailsEntity? account;
  @JsonKey(name: "customer")
  final CustomerDetailsEntity? customer;

  GetAccountContentEntity({this.account, this.customer});

  factory GetAccountContentEntity.fromJson(Map<String, dynamic> json) =>
      _$GetAccountContentEntityFromJson(json);

  Map<String, dynamic> toJson() => _$GetAccountContentEntityToJson(this);

  @override
  GetAccountContentEntity restore(GetAccountContent response) {
    return GetAccountContentEntity();
  }

  @override
  GetAccountContent transform() {
    return GetAccountContent(
        accountDetails: this.account!.transform(),
        customerInformation: this.customer!.transform());
  }
}
