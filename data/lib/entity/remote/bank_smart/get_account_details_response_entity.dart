import 'package:data/entity/remote/bank_smart/get_account_details_content_entity.dart';
import 'package:data/entity/remote/user/response_entity.dart';
import 'package:domain/model/bank_smart/get_account_details_response.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_account_details_response_entity.g.dart';

@JsonSerializable()
class GetAccountDetailsResponseEntity
    implements
        BaseLayerDataTransformer<GetAccountDetailsResponseEntity,
            GetAccountDetailsResponse> {
  @JsonKey(name: "response")
  final ResponseEntity? responseEntity;

  GetAccountDetailsResponseEntity({this.responseEntity});

  factory GetAccountDetailsResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$GetAccountDetailsResponseEntityFromJson(json);

  Map<String, dynamic> toJson() =>
      _$GetAccountDetailsResponseEntityToJson(this);

  @override
  GetAccountDetailsResponseEntity restore(GetAccountDetailsResponse response) {
    return GetAccountDetailsResponseEntity();
  }

  @override
  GetAccountDetailsResponse transform() {
    return GetAccountDetailsResponse(
        getAccountDetailsContent: GetAccountDetailsContentEntity.fromJson(
                this.responseEntity!.content)
            .transform());
  }
}
