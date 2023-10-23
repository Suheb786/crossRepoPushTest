import 'package:encrypt/encrypt.dart';

class EncryptDecryptPromoCode {
  static String decryptReferLink({required String keyString, required Encrypted encryptedData}) {
    final key = Key.fromUtf8(keyString);
    final encrypter = Encrypter(AES(key, mode: AESMode.gcm));
    final initVector = IV.fromUtf8(keyString.substring(0, 16));
    return encrypter.decrypt(encryptedData, iv: initVector);
  }

//
// static String decryptReferLink({required String encryptedContent, required String decryptionKey}) {
//    try {
//      Uint8List encryptedBytes = base64.decode(encryptedContent);
//      Uint8List keyBytes = Uint8List.fromList(decryptionKey.codeUnits);
//      KeyParameter keyParameter = KeyParameter(keyBytes);
//
//      final cbcCipher = AESEngine()..init(false, keyParameter);
//
//      final gcmCipher = GCMBlockCipher(cbcCipher);
//      final params = AEADParameters(keyParameter, 128, Uint8List(16), Uint8List(0));
//      gcmCipher.init(false, params);
//
//      final decrypted = gcmCipher.process(encryptedBytes);
//
//      var decryptedData = utf8.decode(decrypted);
//      helper.KeyHelper.setKeyValues(decryptedData);
//      return decryptedData;
//    } catch (error) {
//      throw error;
//    }
//  }

  static String encryptReferLink({required String keyString, required String plainText}) {
    final key = Key.fromUtf8(keyString);
    final encrypter = Encrypter(AES(key, mode: AESMode.gcm));
    final initVector = IV.fromUtf8(keyString.substring(0, 16));
    Encrypted encryptedData = encrypter.encrypt(plainText, iv: initVector);
    return encryptedData.base16;
  }

//
// static String encryptReferLink({required String data,required String key}) {
//   Uint8List dataBytes = Uint8List.fromList(data.codeUnits);
//   Uint8List keyBytes = Uint8List.fromList(key.codeUnits);
//   KeyParameter keyParameter = KeyParameter(keyBytes);
//   final cbcCipher = AESEngine()..init(true, keyParameter);
//   final gcmCipher = GCMBlockCipher(cbcCipher);
//   final params = AEADParameters(keyParameter, 128, Uint8List(16), Uint8List(0));
//   gcmCipher.init(true, params);
//   final encrypted = gcmCipher.process(dataBytes);
//   return base64.encode(encrypted.toList());
// }
}
