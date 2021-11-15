import 'package:data/db/floor/constants/database_tables.dart';
import 'package:domain/model/user/user.dart';
import 'package:domain/utils/mapper/base_layer_data_transformer.dart';
import 'package:floor/floor.dart';

@Entity(tableName: Table.USER, indices: [
  Index(value: ['email'], unique: true)
])
class UserDBEntity extends BaseLayerDataTransformer<UserDBEntity, User> {
  @primaryKey
  String? email;
  String? id;
  String? firstName;
  String? lastName;
  String? mobile;
  bool? isCurrent;
  String? token;
  String? refreshToken;
  int? expiresIn;
  String? tokenType;

  UserDBEntity(
      {this.id,
      this.token,
      this.firstName,
      this.lastName,
      this.email,
      this.mobile,
      this.isCurrent,
      this.refreshToken,
      this.tokenType,
      this.expiresIn});

  @override
  transform() {
    return User(
        id: id,
        token: token,
        firstName: firstName,
        lastName: lastName,
        email: email,
        mobile: mobile,
        isCurrent: isCurrent,
        expiredIn: expiresIn,
        tokenType: tokenType,
        refreshToken: refreshToken);
  }

  @override
  UserDBEntity restore(User data) {
    this.id = data.id;
    this.token = data.token;
    this.firstName = data.firstName;
    this.lastName = data.lastName;
    this.mobile = data.mobile;
    this.email = data.email;
    this.isCurrent = data.isCurrent;
    this.expiresIn = data.expiredIn;
    this.refreshToken = data.refreshToken;
    this.tokenType = data.tokenType;
    return this;
  }
}
