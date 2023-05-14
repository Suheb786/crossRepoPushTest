import 'package:data/entity/remote/base/base_class.dart';
import 'package:json_annotation/json_annotation.dart';

part "fetch_countrylist_request.g.dart";

@JsonSerializable()
class FetchCountryListRequest {
  @JsonKey(name: "getToken")
  final bool? getToken;
  @JsonKey(name: "baseClass")
  final BaseClassEntity baseData;

  FetchCountryListRequest({this.getToken= true, required this.baseData});

  factory FetchCountryListRequest.fromJson(Map<String, dynamic> json) =>
      _$FetchCountryListRequestFromJson(json);

  Map<String, dynamic> toJson() => _$FetchCountryListRequestToJson(this);
}
