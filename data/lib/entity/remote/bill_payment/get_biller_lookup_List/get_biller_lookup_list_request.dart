import 'package:json_annotation/json_annotation.dart';

part 'get_biller_lookup_list_request.g.dart';

@JsonSerializable()
class GetBillerLookupListRequest {
  @JsonKey(name: "categoryName")
  String? categoryName;

  @JsonKey(name: "GetToken")
  final bool? getToken;
  @JsonKey(name: "BaseClass")
  final Map<String, dynamic> baseData;

  GetBillerLookupListRequest(
      {this.categoryName, this.getToken, required this.baseData});

  factory GetBillerLookupListRequest.fromJson(Map<String, dynamic> json) =>
      _$GetBillerLookupListRequestFromJson(json);

  Map<String, dynamic> toJson() => _$GetBillerLookupListRequestToJson(this);
}
