import 'package:domain/model/user/logout/logout_content.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'logout_content_entity.g.dart';

@JsonSerializable()
class LogoutContentEntity
    implements BaseLayerDataTransformer<LogoutContentEntity, LogoutContent> {
  @JsonKey(name: "bioMetricLogin")
  final bool? bioMetricLogin;

  LogoutContentEntity({this.bioMetricLogin});

  factory LogoutContentEntity.fromJson(Map<String, dynamic> json) =>
      _$LogoutContentEntityFromJson(json);

  Map<String, dynamic> toJson() => _$LogoutContentEntityToJson(this);

  @override
  LogoutContentEntity restore(LogoutContent response) {
    return LogoutContentEntity();
  }

  @override
  LogoutContent transform() {
    return LogoutContent(bioMetricLogin: this.bioMetricLogin);
  }
}
