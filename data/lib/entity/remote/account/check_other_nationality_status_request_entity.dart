import 'package:json_annotation/json_annotation.dart';

part 'check_other_nationality_status_request_entity.g.dart';

@JsonSerializable()
class CheckOtherNationalityStatusRequestEntity {
  @JsonKey(name: "GetToken")
  final bool? getToken;
  @JsonKey(name: "baseClass")
  final Map<String, dynamic> baseData;

  CheckOtherNationalityStatusRequestEntity({this.getToken: true, required this.baseData});

  factory CheckOtherNationalityStatusRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$CheckOtherNationalityStatusRequestEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CheckOtherNationalityStatusRequestEntityToJson(this);
}
