import 'package:data/entity/remote/user/register_interest/register_interest_content_entity.dart';
import 'package:data/entity/remote/user/response_entity.dart';
import 'package:domain/model/user/register_interest/register_interest_response.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'register_interest_response_entity.g.dart';

@JsonSerializable()
class RegisterInterestResponseEntity extends BaseLayerDataTransformer<
    RegisterInterestResponseEntity, RegisterInterestResponse> {
  @JsonKey(name: "response")
  final ResponseEntity? response;

  RegisterInterestResponseEntity(this.response);

  factory RegisterInterestResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$RegisterInterestResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterInterestResponseEntityToJson(this);

  @override
  RegisterInterestResponse transform() {
    return RegisterInterestResponse(
        registerInterestContent:
            RegisterInterestContentEntity.fromJson(this.response!.content)
                .transform());
  }
}
