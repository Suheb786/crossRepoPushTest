import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:domain/model/payment/get_rejection_reason/reject_reasons_response.dart';
part 'reject_reason_list_response_entity.g.dart';

@JsonSerializable()
class RejctReasonListEntity extends BaseLayerDataTransformer<RejctReasonListEntity, RejectReasonsPayment> {
  @JsonKey(name: "code")
  final String? code;
  @JsonKey(name: "description")
  final String? description;

  RejctReasonListEntity({
    required this.code,
    required this.description,
  });
  factory RejctReasonListEntity.fromJson(Map<String, dynamic> json) => _$RejctReasonListEntityFromJson(json);

  Map<String, dynamic> toJson() => _$RejctReasonListEntityToJson(this);

  @override
  RejectReasonsPayment transform() {
    return RejectReasonsPayment(
      code: this.code,
      description: this.description,
    );
  }
}
