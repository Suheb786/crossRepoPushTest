import 'package:data/entity/remote/base/base_class.dart';
import 'package:json_annotation/json_annotation.dart';

part "get_ahwal_details_request.g.dart";

@JsonSerializable()
class GetAhwalDetailsRequest {
  @JsonKey(name: "IdNo")
  final String? idNo;
  @JsonKey(name: "baseClass")
  final BaseClassEntity baseData;

  GetAhwalDetailsRequest({this.idNo: "", required this.baseData});

  factory GetAhwalDetailsRequest.fromJson(Map<String, dynamic> json) =>
      _$GetAhwalDetailsRequestFromJson(json);

  Map<String, dynamic> toJson() => _$GetAhwalDetailsRequestToJson(this);
}
