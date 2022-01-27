import 'package:json_annotation/json_annotation.dart';

part "apply_debit_supplementary_card_request.g.dart";

@JsonSerializable()
class ApplyDebitSupplementaryCardRequest {
  @JsonKey(name: "NickName")
  final String? nickName;
  @JsonKey(name: "Relation")
  final String? relation;
  @JsonKey(name: "id")
  final String? id;
  @JsonKey(name: "type")
  final String? type;
  @JsonKey(name: "FullName")
  final String? fullName;
  @JsonKey(name: "FirstName")
  final String? firstName;
  @JsonKey(name: "MiddleName")
  final String? middleName;
  @JsonKey(name: "FamilyName")
  final String? familyName;
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
  @JsonKey(name: "GetToken")
  final bool? getToken;
  @JsonKey(name: "instanceID")
  final String? instanceID;
  @JsonKey(name: "scanPercentage")
  final num? scanPercentage;

  @JsonKey(name: "BaseClass")
  final Map<String, dynamic> baseData;

  ApplyDebitSupplementaryCardRequest(
      {this.id,
      this.type,
      this.fullName,
      this.firstName,
      this.middleName,
      this.familyName,
      this.idNumber,
      this.dob,
      this.nationality,
      this.doe,
      this.gender,
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
      this.instanceID,
      this.scanPercentage,
      required this.baseData,
      this.nickName,
      this.relation});

  factory ApplyDebitSupplementaryCardRequest.fromJson(
          Map<String, dynamic> json) =>
      _$ApplyDebitSupplementaryCardRequestFromJson(json);

  Map<String, dynamic> toJson() =>
      _$ApplyDebitSupplementaryCardRequestToJson(this);
}
