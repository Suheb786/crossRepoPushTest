import 'package:data/entity/remote/payment/transfer_success_content_entity.dart';
import 'package:data/entity/remote/user/response_entity.dart';
import 'package:domain/model/payment/transfer_success_response.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part "transfer_success_response_entity.g.dart";

@JsonSerializable()
class TransferSuccessResponseEntity
    implements
        BaseLayerDataTransformer<TransferSuccessResponseEntity,
            TransferSuccessResponse> {
  @JsonKey(name: "response")
  final ResponseEntity? response;

  TransferSuccessResponseEntity({this.response});

  factory TransferSuccessResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$TransferSuccessResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$TransferSuccessResponseEntityToJson(this);

  @override
  TransferSuccessResponseEntity restore(TransferSuccessResponse response) {
    return TransferSuccessResponseEntity();
  }

  @override
  TransferSuccessResponse transform() {
    return TransferSuccessResponse(
        transferSuccessContent:
            TransferSuccessContentEntity.fromJson(this.response!.content)
                .transform());
  }
}
