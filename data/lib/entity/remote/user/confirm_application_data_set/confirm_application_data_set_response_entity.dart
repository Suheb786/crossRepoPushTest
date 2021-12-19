import 'package:data/entity/remote/user/response_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'confirm_application_data_set_response_entity.g.dart';

@JsonSerializable()
class ConfirmApplicationDataSetResponseEntity {
  @JsonKey(name: "response")
  final ResponseEntity? response;

  ConfirmApplicationDataSetResponseEntity({this.response});

  factory ConfirmApplicationDataSetResponseEntity.fromJson(
      Map<String, dynamic> json) =>
      _$ConfirmApplicationDataSetResponseEntityFromJson(json);

  Map<String, dynamic> toJson() =>
      _$ConfirmApplicationDataSetResponseEntityToJson(this);
}
