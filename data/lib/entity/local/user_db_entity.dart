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
  String? mobileCode;
  bool? isCurrent;
  String? token;
  String? refreshToken;
  int? expiresIn;
  String? tokenType;
  String? privatePEM;
  String? publicPEM;
  bool? isBiometricEnabled;
  String? cifNumber;
  String? accountNumber;

  UserDBEntity(
      {this.id,
      this.token,
      this.firstName,
      this.lastName,
      this.email,
      this.mobile,
      this.mobileCode,
      this.isCurrent,
      this.refreshToken,
      this.tokenType,
      this.expiresIn,
      this.isBiometricEnabled,
      this.privatePEM,
      this.cifNumber,
      this.accountNumber,
      this.publicPEM});

  @override
  transform() {
    return User(
        id: id,
        token: token,
        firstName: firstName,
        lastName: lastName,
        email: email,
        mobile: mobile,
        mobileCode: mobileCode,
        isCurrent: isCurrent,
        expiredIn: expiresIn,
        tokenType: tokenType,
        refreshToken: refreshToken,
        publicPEM: publicPEM,
        privatePEM: privatePEM,
        isBiometricEnabled: isBiometricEnabled,
        cifNumber: cifNumber,
        accountNumber: accountNumber);
  }

  @override
  UserDBEntity restore(User data) {
    this.id = data.id;
    this.token = data.token;
    this.firstName = data.firstName;
    this.lastName = data.lastName;
    this.mobile = data.mobile;
    this.mobileCode = data.mobileCode;
    this.email = data.email;
    this.isCurrent = data.isCurrent;
    this.expiresIn = data.expiredIn;
    this.refreshToken = data.refreshToken;
    this.tokenType = data.tokenType;
    this.privatePEM = data.privatePEM;
    this.publicPEM = data.publicPEM;
    this.isBiometricEnabled = data.isBiometricEnabled;
    this.cifNumber = data.cifNumber;
    this.accountNumber = data.accountNumber;
    return this;
  }
}
