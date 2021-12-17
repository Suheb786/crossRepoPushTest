import 'package:data/entity/remote/accountsettings/profile_details_entity.dart';
import 'package:data/entity/remote/user/response_entity.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:json_annotation/json_annotation.dart';

part 'profile_details_response_entity.g.dart';

@JsonSerializable()
class ProfileDetailsResponseEntity
    extends BaseLayerDataTransformer<ProfileDetailsResponseEntity, String> {
  @JsonKey(name: "response")
  final ResponseEntity? responseEntity;

  ProfileDetailsResponseEntity({this.responseEntity});

  factory ProfileDetailsResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$ProfileDetailsResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileDetailsResponseEntityToJson(this);

  @override
  ProfileDetailsResponseEntity restore(String response) {
    return ProfileDetailsResponseEntity();
  }

  @override
  String transform() {
    return ProfileDetailsEntity.fromJson(responseEntity!.content).transform();
  }
}
