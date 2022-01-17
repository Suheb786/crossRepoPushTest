import 'package:domain/model/card/process_loan_request/process_loan_request_content.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part "process_loan_content_entity.g.dart";

@JsonSerializable()
class ProcessLoanContentEntity
    implements
        BaseLayerDataTransformer<ProcessLoanContentEntity,
            ProcessLoanRequestContent> {
  @JsonKey(name: "cardid")
  final String? cardId;

  ProcessLoanContentEntity({this.cardId});

  factory ProcessLoanContentEntity.fromJson(Map<String, dynamic> json) =>
      _$ProcessLoanContentEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ProcessLoanContentEntityToJson(this);

  @override
  ProcessLoanContentEntity restore(ProcessLoanRequestContent response) {
    return ProcessLoanContentEntity();
  }

  @override
  ProcessLoanRequestContent transform() {
    return ProcessLoanRequestContent(cardId: this.cardId);
  }
}
