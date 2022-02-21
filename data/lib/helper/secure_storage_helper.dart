import 'dart:convert';

import 'package:domain/model/user/generate_key_pair/generate_key_pair_content.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageHelper {
  final _storage = new FlutterSecureStorage();

  static const String KEY_PAIR = "keyPair";

  SecureStorageHelper._privateConstructor();

  static final SecureStorageHelper _instance =
      SecureStorageHelper._privateConstructor();

  static SecureStorageHelper get instance {
    return _instance;
  }

  ///save user data to secure storage
  Future<void> saveToSecureStorage({GenerateKeyPairContent? keyPairs}) async {
    return _storage.write(
        key: KEY_PAIR, value: json.encode(keyPairs!.toJson()));
  }

  ///get secure data
  Future<GenerateKeyPairContent?> getSecuredValue() async {
    String? keyPairString = await _storage.read(key: KEY_PAIR);
    print('$keyPairString');
    if (keyPairString != null) {
      GenerateKeyPairContent user =
          GenerateKeyPairContent.fromJson(json.decode(keyPairString));
      return user;
    }
  }

  ///clear data
  Future<void> clearSecuredKey() async {
    return _storage.delete(key: KEY_PAIR);
  }
}
