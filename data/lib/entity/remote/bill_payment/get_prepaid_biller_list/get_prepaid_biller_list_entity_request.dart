import 'package:json_annotation/json_annotation.dart';

part 'get_prepaid_biller_list_entity_request.g.dart';

@JsonSerializable()
class GetPrePaidBillerListEntityRequest {
  GetPrePaidBillerListEntityRequest();

  factory GetPrePaidBillerListEntityRequest.fromJson(Map<String, dynamic> json) =>
      _$GetPrePaidBillerListEntityRequestFromJson(json);

  Map<String, dynamic> toJson() => _$GetPrePaidBillerListEntityRequestToJson(this);
}
