import 'package:json_annotation/json_annotation.dart';

part "get_ahwal_details_request.g.dart";

@JsonSerializable()
class GetAhwalDetailsRequest {
  @JsonKey(name: "IdNo")
  final String? idNo;
  @JsonKey(name: "baseClass")
  final Map<String,dynamic> baseData;

  GetAhwalDetailsRequest({this.idNo: "", required this.baseData});

  factory GetAhwalDetailsRequest.fromJson(Map<String, dynamic> json) =>
      _$GetAhwalDetailsRequestFromJson(json);

  Map<String, dynamic> toJson() => _$GetAhwalDetailsRequestToJson(this);
}
