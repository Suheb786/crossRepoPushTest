import 'package:data/entity/remote/bank_smart/create_account_content_entity.dart';
import 'package:data/entity/remote/user/response_entity.dart';
import 'package:domain/model/bank_smart/create_account_response.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_account_response_entity.g.dart';

@JsonSerializable()
class CreateAccountResponseEntity
    implements
        BaseLayerDataTransformer<CreateAccountResponseEntity,
            CreateAccountResponse> {
  @JsonKey(name: "response")
  final ResponseEntity? responseEntity;

  CreateAccountResponseEntity({this.responseEntity});

  factory CreateAccountResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$CreateAccountResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CreateAccountResponseEntityToJson(this);

  @override
  CreateAccountResponseEntity restore(CreateAccountResponse response) {
    return CreateAccountResponseEntity();
  }

  @override
  CreateAccountResponse transform() {
    return CreateAccountResponse(
        content:
        CreateAccountContentEntity.fromJson(this.responseEntity!.content)
            .transform());
  }
}
