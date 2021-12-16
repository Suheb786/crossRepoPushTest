import 'package:json_annotation/json_annotation.dart';

part 'doc_status_request_entity.g.dart';

@JsonSerializable()
class DocStatusRequestEntity {
  @JsonKey(name: "GetToken")
  final bool? getToken;
  @JsonKey(name: "baseClass")
  final Map<String, dynamic> baseData;

  DocStatusRequestEntity({this.getToken, required this.baseData});

  factory DocStatusRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$DocStatusRequestEntityFromJson(json);

  Map<String, dynamic> toJson() => _$DocStatusRequestEntityToJson(this);
}
