import 'package:json_annotation/json_annotation.dart';

part 'remove_prepaid_biller_request.g.dart';

@JsonSerializable()
class RemovePrepaidBillerRequest {
  @JsonKey(name: "registrationID")
  final String? registrationID;

  RemovePrepaidBillerRequest({
    required this.registrationID,
  });

  factory RemovePrepaidBillerRequest.fromJson(Map<String, dynamic> json) =>
      _$RemovePrepaidBillerRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RemovePrepaidBillerRequestToJson(this);
}
