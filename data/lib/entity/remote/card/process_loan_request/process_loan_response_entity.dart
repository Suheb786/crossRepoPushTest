import 'package:data/entity/remote/card/process_loan_request/process_loan_content_entity.dart';
import 'package:data/entity/remote/user/response_entity.dart';
import 'package:domain/model/card/process_loan_request/process_loan_request_response.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part "process_loan_response_entity.g.dart";

@JsonSerializable()
class ProcessLoanResponseEntity
    implements
        BaseLayerDataTransformer<ProcessLoanResponseEntity,
            ProcessLoanRequestResponse> {
  @JsonKey(name: "response")
  final ResponseEntity? response;

  ProcessLoanResponseEntity({this.response});

  factory ProcessLoanResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$ProcessLoanResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ProcessLoanResponseEntityToJson(this);

  @override
  ProcessLoanResponseEntity restore(ProcessLoanRequestResponse response) {
    return ProcessLoanResponseEntity();
  }

  @override
  ProcessLoanRequestResponse transform() {
    return ProcessLoanRequestResponse(
        processLoanRequestContent:
            ProcessLoanContentEntity.fromJson(this.response!.content)
                .transform());
  }
}
