import 'dart:convert';

import 'package:data/entity/local/base/rsa_key_helper.dart';
import 'package:data/helper/key_helper.dart' as helper;
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter/services.dart';
import 'package:pointycastle/api.dart';
import 'package:pointycastle/block/aes.dart';
import 'package:pointycastle/block/modes/gcm.dart';

final _keyHelper = RsaKeyHelper();

///RSA encryption
Future<String> encryptData({String? content, String? publicKey, String? privateKey}) async {
  try {
    var encrypter = encrypt.Encrypter(encrypt.RSA(
        publicKey: _keyHelper.parsePublicKeyFromPem(publicKey),
        privateKey: _keyHelper.parsePrivateKeyFromPem(privateKey),
        encoding: encrypt.RSAEncoding.OAEP));
    return Future.value(encrypter.encrypt(content!).base64);
  } catch (e) {
    return Future.value('');
  }
}

String signedData({required String userId, required String privateKey}) {
  return _keyHelper.sign(userId, _keyHelper.parsePrivateKeyFromPem(privateKey));
}

String decryptData({String? content, String? publicKey, String? privateKey}) {
  try {
    var encrypter = encrypt.Encrypter(encrypt.RSA(
        publicKey: _keyHelper.parsePublicKeyFromPem(publicKey),
        privateKey: _keyHelper.parsePrivateKeyFromPem(privateKey),
        encoding: encrypt.RSAEncoding.OAEP));
    return encrypter.decrypt64(content!);
  } catch (e) {
    return '';
  }
}

///AES decryption of currentVersionPE content
String decryptAESCryptoJS({required String encryptedContent, required String decryptionKey}) {
  try {
    Uint8List encryptedBytes = base64.decode(encryptedContent);
    Uint8List keyBytes = Uint8List.fromList(decryptionKey.codeUnits);
    KeyParameter keyParameter = KeyParameter(keyBytes);

    final cbcCipher = AESEngine()..init(false, keyParameter);

    final gcmCipher = GCMBlockCipher(cbcCipher);
    final params = AEADParameters(keyParameter, 128, Uint8List(16), Uint8List(0));
    gcmCipher.init(false, params);

    final decrypted = gcmCipher.process(encryptedBytes);

    var decryptedData = utf8.decode(decrypted);
    helper.KeyHelper.setKeyValues(decryptedData);
    return decryptedData;
  } catch (error) {
    throw error;
  }
}
