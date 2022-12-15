import 'package:json_annotation/json_annotation.dart';

part 'get_postpaid_biller_list_entity_request.g.dart';

@JsonSerializable()
class GetPostPaidBillerListEntityRequest {
  GetPostPaidBillerListEntityRequest();

  factory GetPostPaidBillerListEntityRequest.fromJson(Map<String, dynamic> json) =>
      _$GetPostPaidBillerListEntityRequestFromJson(json);

  Map<String, dynamic> toJson() => _$GetPostPaidBillerListEntityRequestToJson(this);
}
