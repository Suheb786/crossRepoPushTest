import 'package:data/entity/remote/bank_smart/get_account_content_entity.dart';
import 'package:data/entity/remote/user/response_entity.dart';
import 'package:domain/model/bank_smart/get_account_response.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_account_response_entity.g.dart';

@JsonSerializable()
class GetAccountResponseEntity
    implements
        BaseLayerDataTransformer<GetAccountResponseEntity, GetAccountResponse> {
  @JsonKey(name: "response")
  final ResponseEntity? response;

  GetAccountResponseEntity({this.response});

  factory GetAccountResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$GetAccountResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$GetAccountResponseEntityToJson(this);

  @override
  GetAccountResponseEntity restore(GetAccountResponse response) {
    return GetAccountResponseEntity();
  }

  @override
  GetAccountResponse transform() {
    return GetAccountResponse(
        content: GetAccountContentEntity.fromJson(this.response!.content)
            .transform());
  }
}
