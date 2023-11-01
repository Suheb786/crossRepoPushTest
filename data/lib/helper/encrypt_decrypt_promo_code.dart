import 'package:encrypt/encrypt.dart';

class EncryptDecryptPromoCode {
  static String decryptReferLink({required String keyString, required Encrypted encryptedData}) {
    final key = Key.fromUtf8(keyString);
    final encrypter = Encrypter(AES(key, mode: AESMode.gcm));
    final initVector = IV.fromUtf8(keyString.substring(0, 16));
    return encrypter.decrypt(encryptedData, iv: initVector);
  }

  static String encryptReferLink({required String keyString, required String plainText}) {
    final key = Key.fromUtf8(keyString);
    final encrypter = Encrypter(AES(key, mode: AESMode.gcm));
    final initVector = IV.fromUtf8(keyString.substring(0, 16));
    Encrypted encryptedData = encrypter.encrypt(plainText, iv: initVector);
    return encryptedData.base16;
  }
}
