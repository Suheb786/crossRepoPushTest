// import 'dart:convert';
// import 'dart:math';
// import 'dart:typed_data';
// import 'package:khf_wealth/util/app_constants.dart';
// import 'package:khf_wealth/util/rsa_key_helper.dart';
// import 'package:khf_wealth/util/shared_pref_manager.dart';
// import 'package:tuple/tuple.dart';
// import 'package:encrypt/encrypt.dart' as encrypt;
// import 'package:pointycastle/pointycastle.dart';
// import 'dart:convert' as convert;
//
// final _rsaHelper = RsaKeyHelper();
//
// PublicKey _publicKey;
// PrivateKey _privateKey;
//
// Future loadKeys() async {
//   try {
//     String publicKey = await SharedPrefManager.instance
//         .getSecuredValue(key: AppConstants.BIO_PUBLIC_KEY);
//     String privateKey = await SharedPrefManager.instance
//         .getSecuredValue(key: AppConstants.BIO_PRIVATE_KEY);
//     print('Public key : ' + publicKey);
//     print('Private key : ' + privateKey);
//     if (publicKey != null) {
//       _publicKey = _rsaHelper.parsePublicKeyFromPem(publicKey);
//     }
//     if (privateKey != null) {
//       _privateKey = _rsaHelper.parsePrivateKeyFromPem(privateKey);
//     }
//   } catch (e) {
//     print("Load Key Error " + e.toString());
//   }
//   return Future.value(null);
// }
//
// Future saveKey({String key, String rsaKey}) async {
//   return SharedPrefManager.instance
//       .saveToSecurePreference(key: key, value: rsaKey);
// }
//
// ///RSA encryption
// Future<String> encryptData({String content}) async {
//   if (_publicKey == null || _privateKey == null) {
//     await loadKeys();
//   }
//   var encrypter = encrypt.Encrypter(encrypt.RSA(
//       publicKey: _publicKey,
//       privateKey: _privateKey,
//       encoding: encrypt.RSAEncoding.PKCS1));
//   return Future.value(encrypter.encrypt(content).base64);
//   // RSAEncoding.PKCS1
// }
//
// String signedData({String content}) {
//   return _rsaHelper.sign(content, _privateKey);
// }
//
// String decryptData({String content}) {
//   var encrypter = encrypt.Encrypter(encrypt.RSA(
//       publicKey: _publicKey,
//       privateKey: _privateKey,
//       encoding: encrypt.RSAEncoding.PKCS1));
//   return encrypter.decrypt64(content);
// }
//
// ///AES encryption
// Tuple2<String, String> finalDataEncrypt(String data) {
//   String randomKey = generateRandomKey();
//
//   Uint8List random =
//       encrypt.Key.fromBase64(convert.base64Encode(utf8.encode(randomKey)))
//           .bytes; //encrypt.Key.fromLength(16).bytes;
//   var key = encrypt.Key(random);
//   var iv = encrypt.IV(random);
//   print("Key Length " + key.bytes.length.toString());
//   print("IV Length " + iv.bytes.length.toString());
//
//   String encryptedKey = encryptPublicKey(key);
//   String encryptedData = _encryptRequestData(key, iv, data);
//   return Tuple2(encryptedKey, encryptedData);
// }
//
// String generateRandomKey() {
//   const _chars =
//       'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
//   Random _rnd = Random();
//   var randomKey = String.fromCharCodes(Iterable.generate(
//       16, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
//
//   return randomKey.toString().length > 16
//       ? randomKey.toString().substring(0, 16)
//       : randomKey.toString();
// }
//
// int nextInt(int min, int max) => min + Random().nextInt((max + 1) - min);
//
// String _encryptRequestData(encrypt.Key key, encrypt.IV iv, String data) {
//   final encrypter = encrypt.Encrypter(
//       encrypt.AES(key, mode: encrypt.AESMode.cbc, padding: "PKCS7"));
//   return encrypter.encrypt(data, iv: iv).base64;
// }
//
// ///RSA encryption
// String encryptPublicKey(encrypt.Key key) {
//   String serverPublicKey = AppConstants.publicKey;
//
//   ///RSA encrypt
//   final encrypter = encrypt.Encrypter(encrypt.RSA(
//       publicKey: _rsaHelper.parsePublicKeyFromPem(serverPublicKey)));
//   return encrypter.encrypt(utf8.decode(key.bytes)).base64;
// }
//
// ///Decrypting response
// ///AES decryption
// String decryptAESCryptoJS(String encrypted, String passphrase) {
//   try {
//     var key = encrypt.Key(encrypt.Key.fromUtf8(passphrase).bytes);
//     var iv = encrypt.IV(encrypt.Key.fromUtf8(passphrase).bytes);
//     final encrypter = encrypt.Encrypter(
//         encrypt.AES(key, mode: encrypt.AESMode.cbc, padding: "PKCS7"));
//     final decrypted = encrypter.decrypt64(encrypted, iv: iv);
//     print('decrypted : ' + decrypted);
//     return decrypted;
//   } catch (error) {
//     throw error;
//   }
// }
