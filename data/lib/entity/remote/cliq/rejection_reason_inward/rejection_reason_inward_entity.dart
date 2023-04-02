import 'package:domain/model/cliq/rejection_reason_inward_request/rejection_reason_inward.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'rejection_reason_inward_entity.g.dart';

@JsonSerializable()
class RejectionReasonInwardEntity
    implements BaseLayerDataTransformer<RejectionReasonInwardEntity, RejectionReasonInward> {
  @JsonKey(name: "code", defaultValue: '')
  final String? code;
  @JsonKey(name: "description", defaultValue: '')
  final String? description;

  RejectionReasonInwardEntity({this.code, this.description});

  factory RejectionReasonInwardEntity.fromJson(Map<String, dynamic> json) =>
      _$RejectionReasonInwardEntityFromJson(json);

  Map<String, dynamic> toJson() => _$RejectionReasonInwardEntityToJson(this);

  @override
  RejectionReasonInwardEntity restore(RejectionReasonInward data) {
    throw UnimplementedError();
  }

  @override
  RejectionReasonInward transform() {
    return RejectionReasonInward(code: this.code ?? '', description: this.description ?? '');
  }
}
