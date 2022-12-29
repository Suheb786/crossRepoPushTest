import 'package:data/entity/remote/user/response_entity.dart';
import 'package:domain/model/cliq/get_account_by_customer_id/get_account_by_customer_id.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

import 'get_account_by_customer_id_entity.dart';

part 'get_account_by_customer_id_response_entity.g.dart';

@JsonSerializable()
class GetAccountByCustomerIdResponseEntity
    implements BaseLayerDataTransformer<GetAccountByCustomerIdResponseEntity, List<GetAccountByCustomerId>> {
  @JsonKey(name: "response")
  final ResponseEntity? response;

  GetAccountByCustomerIdResponseEntity(this.response);

  factory GetAccountByCustomerIdResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$GetAccountByCustomerIdResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$GetAccountByCustomerIdResponseEntityToJson(this);

  @override
  GetAccountByCustomerIdResponseEntity restore(List<GetAccountByCustomerId> data) {
    throw UnimplementedError();
  }

  @override
  List<GetAccountByCustomerId> transform() {
    var content = response?.content as List<dynamic>;
    List<GetAccountByCustomerId> result = [];
    if (content.isNotEmpty) {
      result = content.map((e) {
        return GetAccountByCustomerIdEntity.fromJson(e as Map<String, dynamic>).transform();
      }).toList();
    }
    return result;
  }
}
