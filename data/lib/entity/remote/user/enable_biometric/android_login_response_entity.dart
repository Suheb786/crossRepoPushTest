import 'package:data/entity/remote/user/enable_biometric/android_login_content_entity.dart';
import 'package:data/entity/remote/user/response_entity.dart';
import 'package:domain/model/user/biometric_login/android_login_response.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'android_login_response_entity.g.dart';

@JsonSerializable()
class AndroidLoginResponseEntity
    implements BaseLayerDataTransformer<AndroidLoginResponseEntity, AndroidLoginResponse> {
  @JsonKey(name: "response")
  final ResponseEntity? response;

  AndroidLoginResponseEntity({this.response});

  factory AndroidLoginResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$AndroidLoginResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$AndroidLoginResponseEntityToJson(this);

  @override
  AndroidLoginResponseEntity restore(AndroidLoginResponse response) {
    return AndroidLoginResponseEntity();
  }

  @override
  AndroidLoginResponse transform() {
    return AndroidLoginResponse(
        androidLoginContent:
            AndroidLoginContentEntity.fromJson(this.response!.content as Map<String, dynamic>).transform());
  }
}
