import 'package:domain/model/user/content.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'content_entity.g.dart';

@JsonSerializable()
class ContentEntity implements BaseLayerDataTransformer<ContentEntity, Content> {
  @JsonKey(name: "isExisting")
  final bool? isExisting;

  ContentEntity({this.isExisting: false});

  factory ContentEntity.fromJson(Map<String, dynamic> json) => _$ContentEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ContentEntityToJson(this);

  @override
  ContentEntity restore(Content content) {
    return ContentEntity();
  }

  @override
  Content transform() {
    return Content(isExisting: this.isExisting);
  }
}
