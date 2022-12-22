import 'package:data/entity/remote/cliq/request_money_activity/response/request_money_activity_entity.dart';
import 'package:data/entity/remote/user/response_entity.dart';
import 'package:domain/model/cliq/request_money_activity/request_money_activity.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';
part 'request_money_activity_response_entity.g.dart';

@JsonSerializable()
class RequestMoneyActivityResponseEntity extends BaseLayerDataTransformer<
    RequestMoneyActivityResponseEntity, RequestMoneyActivity> {
  @JsonKey(name: "response")
  final ResponseEntity? response;

  RequestMoneyActivityResponseEntity(this.response);
  factory RequestMoneyActivityResponseEntity.fromJson(
          Map<String, dynamic> json) =>
      _$RequestMoneyActivityResponseEntityFromJson(json);

  Map<String, dynamic> toJson() =>
      _$RequestMoneyActivityResponseEntityToJson(this);

  @override
  RequestMoneyActivity transform() {
    return RequestMoneyActivityEntity.fromJson(
            response?.content as Map<String, dynamic>)
        .transform();
  }
}
