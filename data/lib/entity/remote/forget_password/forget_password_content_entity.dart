import 'package:domain/model/forget_password/forget_password_content.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part "forget_password_content_entity.g.dart";

@JsonSerializable()
class ForgetPasswordContentEntity
    implements
        BaseLayerDataTransformer<ForgetPasswordContentEntity,
            ForgetPasswordContent> {
  @JsonKey(name: "mobileNumber")
  final String? mobileNumber;

  ForgetPasswordContentEntity({this.mobileNumber});

  factory ForgetPasswordContentEntity.fromJson(Map<String, dynamic> json) =>
      _$ForgetPasswordContentEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ForgetPasswordContentEntityToJson(this);

  @override
  ForgetPasswordContentEntity restore(ForgetPasswordContent response) {
    return ForgetPasswordContentEntity();
  }

  @override
  ForgetPasswordContent transform() {
    return ForgetPasswordContent(mobileNumber: this.mobileNumber);
  }
}
