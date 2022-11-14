import 'package:json_annotation/json_annotation.dart';

part 'get_biller_lookup_list_request.g.dart';

@JsonSerializable()
class GetBillerLookupListRequest {
  @JsonKey(name: "categoryName")
  String? categoryName;

  GetBillerLookupListRequest({
     this.categoryName,
  });

  factory GetBillerLookupListRequest.fromJson(Map<String, dynamic> json) =>
      _$GetBillerLookupListRequestFromJson(json);

  Map<String, dynamic> toJson() => _$GetBillerLookupListRequestToJson(this);
}
