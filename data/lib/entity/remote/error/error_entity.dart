import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:domain/error/api_error_model.dart';

part 'error_entity.g.dart';

@JsonSerializable()
class ErrorEntity extends BaseLayerDataTransformer<ErrorEntity, APIErrorModel> {
  @JsonKey(name: "TitleAr")
  final String? titleAr;
  @JsonKey(name: "TitleEn")
  final String? titleEn;
  @JsonKey(name: "MessageEn")
  final String? messageEn;
  @JsonKey(name: "MessageAr")
  final String? messageAr;
  @JsonKey(name: "Code")
  final String? code;

  ErrorEntity({this.code, this.titleAr, this.titleEn, this.messageAr, this.messageEn});

  factory ErrorEntity.fromJson(Map<String, dynamic> json) => _$ErrorEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ErrorEntityToJson(this);

  @override
  APIErrorModel transform() {
    return APIErrorModel(
        code: this.code ?? "",
        titleAr: this.titleAr ?? "",
        titleEn: this.titleEn ?? "",
        messageAr: this.messageAr ?? "",
        messageEn: this.messageEn ?? "");
  }
}
