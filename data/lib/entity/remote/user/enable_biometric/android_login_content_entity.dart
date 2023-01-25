import 'package:domain/model/user/biometric_login/android_login_content.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'android_login_content_entity.g.dart';

@JsonSerializable()
class AndroidLoginContentEntity
    implements BaseLayerDataTransformer<AndroidLoginContentEntity, AndroidLoginContent> {
  @JsonKey(name: "applepay")
  final bool? applepay;

  AndroidLoginContentEntity({this.applepay});

  factory AndroidLoginContentEntity.fromJson(Map<String, dynamic> json) =>
      _$AndroidLoginContentEntityFromJson(json);

  Map<String, dynamic> toJson() => _$AndroidLoginContentEntityToJson(this);

  @override
  AndroidLoginContentEntity restore(AndroidLoginContent response) {
    return AndroidLoginContentEntity();
  }

  @override
  AndroidLoginContent transform() {
    return AndroidLoginContent(applepay: this.applepay ?? false);
  }
}
