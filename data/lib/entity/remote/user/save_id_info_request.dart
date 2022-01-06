import 'package:json_annotation/json_annotation.dart';

part "save_id_info_request.g.dart";

@JsonSerializable()
class SaveIdInfoRequest {
  @JsonKey(name: "id")
  final String? id;
  @JsonKey(name: "type")
  final String? type;
  @JsonKey(name: "fullName")
  final String? fullName;
  @JsonKey(name: "firstName")
  final String? firstName;
  @JsonKey(name: "middleName")
  final String? middleName;
  @JsonKey(name: "familyName")
  final String? familyName;
  @JsonKey(name: "MotherFirstName")
  final String? motherName;
  @JsonKey(name: "PlaceOfBirth")
  final String? placeOfBirth;
  @JsonKey(name: "doi")
  final String? doi;
  @JsonKey(name: "idNumber")
  final String? idNumber;
  @JsonKey(name: "dob")
  final String? dob;
  @JsonKey(name: "nationality")
  final String? nationality;
  @JsonKey(name: "doe")
  final String? doe;
  @JsonKey(name: "gender")
  final String? gender;
  @JsonKey(name: "documentCode")
  final String? documentCode;
  @JsonKey(name: "documentNumber")
  final String? documentNumber;
  @JsonKey(name: "issuer")
  final String? issuer;
  @JsonKey(name: "optionalData1")
  final String? optionalData1;
  @JsonKey(name: "optionalData2")
  final String? optionalData2;
  @JsonKey(name: "mrtDraw")
  final String? mrtDraw;
  @JsonKey(name: "frontCardImage")
  final String? frontCardImage;
  @JsonKey(name: "backCardImage")
  final String? backCardImage;
  @JsonKey(name: "personFaceImage")
  final String? personFaceImage;
  @JsonKey(name: "getToken")
  final bool? getToken;
  @JsonKey(name: "isimtfBlacklist")
  final bool? isimtfBlacklist;
  @JsonKey(name: "instanceID")
  final String? instanceID;
  @JsonKey(name: "scanPercentage")
  final num? scanPercentage;

  @JsonKey(name: "baseClass")
  final Map<String, dynamic> baseData;

  SaveIdInfoRequest(
      {this.id,
      this.type,
      this.fullName,
      this.firstName,
      this.middleName,
      this.familyName,
      this.idNumber,
      this.dob,
      this.doi,
      this.nationality,
      this.doe,
      this.gender,
      this.motherName,
      this.documentCode,
      this.documentNumber,
      this.issuer,
      this.optionalData1,
      this.optionalData2,
      this.mrtDraw,
      this.frontCardImage,
      this.backCardImage,
      this.personFaceImage,
      this.getToken,
      this.isimtfBlacklist,
      this.instanceID,
      this.scanPercentage,
      required this.baseData,
      this.placeOfBirth});

  factory SaveIdInfoRequest.fromJson(Map<String, dynamic> json) =>
      _$SaveIdInfoRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SaveIdInfoRequestToJson(this);
}
