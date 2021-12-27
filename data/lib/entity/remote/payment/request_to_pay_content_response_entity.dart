import 'package:data/entity/remote/payment/request_to_pay_content_entity.dart';
import 'package:data/entity/remote/user/response_entity.dart';
import 'package:domain/model/payment/request_to_pay_content_response.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part "request_to_pay_content_response_entity.g.dart";

@JsonSerializable()
class RequestToPayContentResponseEntity
    implements
        BaseLayerDataTransformer<RequestToPayContentResponseEntity,
            RequestToPayContentResponse> {
  @JsonKey(name: "response")
  final ResponseEntity? response;

  RequestToPayContentResponseEntity({this.response});

  factory RequestToPayContentResponseEntity.fromJson(
          Map<String, dynamic> json) =>
      _$RequestToPayContentResponseEntityFromJson(json);

  Map<String, dynamic> toJson() =>
      _$RequestToPayContentResponseEntityToJson(this);

  @override
  RequestToPayContentResponseEntity restore(
      RequestToPayContentResponse response) {
    return RequestToPayContentResponseEntity();
  }

  @override
  RequestToPayContentResponse transform() {
    return RequestToPayContentResponse(
        requestToPayContent:
            RequestToPayContentEntity.fromJson(this.response!.content)
                .transform());
  }
}
