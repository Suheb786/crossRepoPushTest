import 'package:domain/model/user/register_interest/register_interest_content.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'register_interest_content_entity.g.dart';

@JsonSerializable()
class RegisterInterestContentEntity
    implements
        BaseLayerDataTransformer<RegisterInterestContentEntity,
            RegisterInterestContent> {
  @JsonKey(name: "referenceNo")
  final String? referenceNo;

  RegisterInterestContentEntity({this.referenceNo});

  factory RegisterInterestContentEntity.fromJson(Map<String, dynamic> json) =>
      _$RegisterInterestContentEntityFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterInterestContentEntityToJson(this);

  @override
  RegisterInterestContentEntity restore(RegisterInterestContent response) {
    return RegisterInterestContentEntity();
  }

  @override
  RegisterInterestContent transform() {
    return RegisterInterestContent(referenceNo: this.referenceNo);
  }
}
