import 'package:data/entity/local/base/rsa_key_helper.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter/cupertino.dart';

final _keyHelper = RsaKeyHelper();

// ///load key from db
// Future loadKeys() async {
//   try {
//     var userEither = await _repository.getCurrentUser();
//     User? user = userEither.fold((l) => null, (r) {
//       return r;
//     });
//     String publicKey = user!.publicPEM!;
//     String privateKey = user.privatePEM!;
//     print('Public key : ' + publicKey);
//     print('Private key : ' + privateKey);
//     if (publicKey != null) {
//       _publicKey = _keyHelper.parsePublicKeyFromPem(publicKey);
//     }
//     if (privateKey != null) {
//       _privateKey = _keyHelper.parsePrivateKeyFromPem(privateKey);
//     }
//   } catch (e) {
//     print("Load Key Error " + e.toString());
//   }
// }

//
// ///save key to db
// Future saveKey({String key, String rsaKey}) async {
//   return SharedPrefManager.instance
//       .saveToSecurePreference(key: key, value: rsaKey);
// }
//

///RSA encryption
Future<String> encryptData(
    {String? content, String? publicKey, String? privateKey}) async {
  print('public Key--->$publicKey');
  print('public Key--->$privateKey');

  var encrypter = encrypt.Encrypter(encrypt.RSA(
      publicKey: _keyHelper.parsePublicKeyFromPem(publicKey),
      privateKey: _keyHelper.parsePrivateKeyFromPem(privateKey),
      encoding: encrypt.RSAEncoding.PKCS1));
  return Future.value(encrypter.encrypt(content!).base64);
}

String signedData({required String userId, required String privateKey}) {
  return _keyHelper.sign(userId, _keyHelper.parsePrivateKeyFromPem(privateKey));
}

String decryptData({String? content, String? publicKey, String? privateKey}) {
  var encrypter = encrypt.Encrypter(encrypt.RSA(
      publicKey: _keyHelper.parsePublicKeyFromPem(publicKey),
      privateKey: _keyHelper.parsePrivateKeyFromPem(privateKey),
      encoding: encrypt.RSAEncoding.PKCS1));
  return encrypter.decrypt64(content!);
}

//
//
// //
// // ///request
// // ///AES encryption
// // Tuple2<String, String> finalDataEncrypt(String data) {
// //   String randomKey = generateRandomKey();
// //
// //   Uint8List random =
// //       encrypt.Key.fromBase64(convert.base64Encode(utf8.encode(randomKey)))
// //           .bytes; //encrypt.Key.fromLength(16).bytes;
// //   var key = encrypt.Key(random);
// //   var iv = encrypt.IV(random);
// //   print("Key Length " + key.bytes.length.toString());
// //   print("IV Length " + iv.bytes.length.toString());
// //
// //   String encryptedKey = encryptPublicKey(key);
// //   String encryptedData = _encryptRequestData(key, iv, data);
// //   return Tuple2(encryptedKey, encryptedData);
// // }
// //
// // String generateRandomKey() {
// //   const _chars =
// //       'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
// //   Random _rnd = Random();
// //   var randomKey = String.fromCharCodes(Iterable.generate(
// //       16, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
// //
// //   return randomKey.toString().length > 16
// //       ? randomKey.toString().substring(0, 16)
// //       : randomKey.toString();
// // }
// //
// // int nextInt(int min, int max) => min + Random().nextInt((max + 1) - min);
// //
// // String _encryptRequestData(encrypt.Key key, encrypt.IV iv, String data) {
// //   final encrypter = encrypt.Encrypter(
// //       encrypt.AES(key, mode: encrypt.AESMode.cbc, padding: "PKCS7"));
// //   return encrypter.encrypt(data, iv: iv).base64;
// // }
// //
// // ///RSA encryption
// // String encryptPublicKey(encrypt.Key key) {
// //   String serverPublicKey = AppConstants.publicKey;
// //
// //   ///RSA encrypt
// //   final encrypter = encrypt.Encrypter(encrypt.RSA(
// //       publicKey: _rsaHelper.parsePublicKeyFromPem(serverPublicKey)));
// //   return encrypter.encrypt(utf8.decode(key.bytes)).base64;
// // }
// //
// // ///Decrypting response

///AES decryption of currentVersionPE content
String decryptAESCryptoJS(
    {required String encryptedContent, required String decryptionKey}) {
  debugPrint('EncryptedContent---->$encryptedContent}');
  debugPrint('key---->$decryptionKey}');
  try {
    var key = encrypt.Key(encrypt.Key.fromUtf8(decryptionKey).bytes);
    var iv = encrypt.IV(encrypt.Key.fromUtf8(decryptionKey).bytes);
    final encrypter = encrypt.Encrypter(
        encrypt.AES(key, mode: encrypt.AESMode.cbc, padding: "PKCS7"));
    final decrypted = encrypter.decrypt64(encryptedContent, iv: iv);
    print('decrypted Data :: ' + decrypted);
    return decrypted;
  } catch (error) {
    throw error;
  }
}
