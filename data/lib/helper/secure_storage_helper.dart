import 'dart:convert';

import 'package:domain/constants/enum/language_enum.dart';
import 'package:domain/model/user/generate_key_pair/generate_key_pair_content.dart';
import 'package:domain/model/user/user.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageHelper {
  final _storage = new FlutterSecureStorage();

  SecureStorageHelper();

  static const String KEY_PAIR = "keyPair";
  static const String LANGUAGE = "language";
  static const String USER = "user";
  static const String WALLET_ID = "walletId";

  SecureStorageHelper._privateConstructor();

  static final SecureStorageHelper _instance = SecureStorageHelper._privateConstructor();

  static SecureStorageHelper get instance {
    return _instance;
  }

  ///save user keys to secure storage
  Future<void> saveToSecureStorage({GenerateKeyPairContent? keyPairs}) async {
    return _storage.write(key: KEY_PAIR, value: json.encode(keyPairs!.toJson()));
  }

  ///get secure keys
  Future<GenerateKeyPairContent?> getSecuredValue() async {
    String? keyPairString = await _storage.read(key: KEY_PAIR);
    print('$keyPairString');
    if (keyPairString != null) {
      GenerateKeyPairContent user = GenerateKeyPairContent.fromJson(json.decode(keyPairString));
      return user;
    }
  }

  ///save user selected language to secure storage
  Future<void> saveUserSelectedLanguageToStorage({String? language}) async {
    return _storage.write(key: LANGUAGE, value: language);
  }

  ///get user selected language from secure storage
  Future<LanguageEnum?> getUserSelectedLanguageFromStorage() async {
    String? language = await _storage.read(key: LANGUAGE);
    if (language != null) {
      LanguageEnum selectedLanguage = language.fromLanguageValue();
      return selectedLanguage;
    } else {
      return LanguageEnum.ENGLISH;
    }
  }

  ///clear data
  Future<void> clearSecuredKey() async {
    return _storage.delete(key: KEY_PAIR);
  }

  ///save user data to secure storage
  Future<bool> saveUserToSecureStorage({User? user}) async {
    User? secureUser = await getUserDataFromSecureStorage();
    //debugPrint('user to save from db ---->${user!.toJson()}');
    if (secureUser != null) {
      // print('secure user not null');
      // debugPrint('secure user from db ---->${secureUser!.toJson()}');
      if (secureUser.id == user!.id) {
        //print('secure user id match');
        secureUser.id = user.id;
        secureUser.token = user.token ?? secureUser.token;
        secureUser.firstName = user.firstName ?? secureUser.firstName;
        secureUser.lastName = user.lastName ?? secureUser.lastName;
        secureUser.email = user.email ?? secureUser.email;
        secureUser.mobileCode = user.mobileCode ?? secureUser.mobileCode;
        secureUser.mobile = user.mobile ?? secureUser.mobile;
        secureUser.isCurrent = user.isCurrent ?? secureUser.isCurrent;
        secureUser.refreshToken = user.refreshToken ?? secureUser.refreshToken;
        secureUser.tokenType = user.tokenType ?? secureUser.tokenType;
        secureUser.expiredIn = user.expiredIn ?? secureUser.expiredIn;
        secureUser.isExisting = user.isExisting ?? secureUser.isExisting;
        secureUser.newDevice = user.newDevice ?? secureUser.newDevice;
        secureUser.privatePEM = user.privatePEM ?? secureUser.privatePEM;
        secureUser.publicPEM = user.publicPEM ?? secureUser.publicPEM;
        secureUser.isBiometricEnabled = user.isBiometricEnabled ?? secureUser.isBiometricEnabled;
        secureUser.cifNumber = user.cifNumber ?? secureUser.cifNumber;
        secureUser.accountNumber = user.accountNumber ?? secureUser.accountNumber;
        secureUser.applicationId = user.applicationId ?? secureUser.applicationId;
        secureUser.selectedLanguage = user.selectedLanguage ?? secureUser.selectedLanguage;

        await _storage.write(key: USER, value: json.encode(secureUser.toJson()));
      } else {
        //print('new  user login');
        await _storage.write(key: USER, value: json.encode(user.toJson()));
      }
    } else {
      //print('secure user inull');
      await _storage.write(key: USER, value: json.encode(user!.toJson()));
    }

    return true;
  }

  Future<User?> getUserDataFromSecureStorage() async {
    String? userString = await _storage.read(key: USER);
    //debugPrint('------$userString');
    if (userString != null) {
      User user = User.fromJson(json.decode(userString));
      return user;
    }
  }

  ///clear user data
  Future<bool> clearUserData() async {
    await _storage.delete(key: USER);
    return true;
  }

  ///wallet id set
  Future<void> saveWalletId({String? walletId}) async {
    return _storage.write(key: WALLET_ID, value: walletId);
  }

  ///get wallet id
  Future<String?> getWalletId() async {
    return _storage.read(key: WALLET_ID);
  }
}
