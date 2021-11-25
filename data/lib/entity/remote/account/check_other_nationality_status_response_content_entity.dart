import 'package:domain/model/account/check_other_nationality_status_content.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'check_other_nationality_status_response_content_entity.g.dart';

@JsonSerializable()
class CheckOtherNationalityStatusResponseContentEntity
    implements
        BaseLayerDataTransformer<CheckOtherNationalityStatusResponseContentEntity,
            CheckOtherNationalityResponseContent> {
  @JsonKey(name: "status")
  final bool? status;

  CheckOtherNationalityStatusResponseContentEntity({this.status});

  factory CheckOtherNationalityStatusResponseContentEntity.fromJson(
      Map<String, dynamic> json) =>
      _$CheckOtherNationalityStatusResponseContentEntityFromJson(json);

  Map<String, dynamic> toJson() =>
      _$CheckOtherNationalityStatusResponseContentEntityToJson(this);

  @override
  CheckOtherNationalityStatusResponseContentEntity restore(
      CheckOtherNationalityResponseContent response) {
    return CheckOtherNationalityStatusResponseContentEntity();
  }

  @override
  CheckOtherNationalityResponseContent transform() {
    return CheckOtherNationalityResponseContent(status: this.status);
  }
}
