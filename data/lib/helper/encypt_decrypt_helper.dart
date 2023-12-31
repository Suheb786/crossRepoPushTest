import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:convert/convert.dart';
import 'package:dart_des/dart_des.dart';
import 'package:data/entity/local/base/rsa_key_helper.dart';
import 'package:data/helper/key_helper.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter/cupertino.dart';
import 'package:string_validator/string_validator.dart';
import 'package:tuple/tuple.dart';
import 'package:pointycastle/export.dart';

class EncryptDecryptHelper {
  EncryptDecryptHelper._();

  static String decryptCard({required String cardNo}) {
    try {
      final List<int> decrypted;
      DES3 desECB = DES3(key: hex.decode(KeyHelper.CARD_DECRYPTION_KEY), mode: DESMode.ECB);
      decrypted = desECB.decrypt(isHexadecimal(cardNo) ? hex.decode(cardNo) : base64.decode(cardNo));
      return String.fromCharCodes(decrypted).replaceAll(RegExp(r'[^0-9]'), '');
    } catch (e) {
      return '';
    }
  }

  static String encryptCard({required String cardNo}) {
    try {
      final List<int> encrypted;
      DES3 desECB = DES3(
          key: hex.decode(KeyHelper.CARD_DECRYPTION_KEY),
          mode: DESMode.ECB,
          paddingType: DESPaddingType.PKCS5);
      encrypted = desECB.encrypt(cardNo.codeUnits);
      return base64.encode(encrypted);
    } catch (e) {
      return '';
    }
  }

  static String generateBlockPin({required String cardNo, required String pinCode}) {
    try {
      final List<int> encrypted;
      String blockPart1 = "0${pinCode.length}$pinCode";
      blockPart1 = blockPart1.padRight(16, 'F');
      String blockPart2 = cardNo.substring(3, cardNo.length - 1).padLeft(16, '0');
      String finalBlock =
          (int.tryParse(blockPart1, radix: 16)! ^ int.tryParse(blockPart2, radix: 16)!).toRadixString(16);
      DES3 desECB = DES3(key: hex.decode(KeyHelper.PIN_BLOCK_KEY), mode: DESMode.ECB);
      encrypted = desECB.encrypt(hex.decode(finalBlock.padLeft(16, '0')));
      return hex.encode(encrypted).substring(0, 16).toUpperCase();
    } catch (e) {
      return '';
    }
  }

  static String generateBlockPinForCreditCard({required String cardNo, required String pinCode}) {
    try {
      final List<int> encrypted;
      String blockPart1 = "0${pinCode.length}$pinCode";
      blockPart1 = blockPart1.padRight(16, 'F');
      String blockPart2 = cardNo.substring(3, cardNo.length - 1).padLeft(16, '0');
      String finalBlock =
          (int.tryParse(blockPart1, radix: 16)! ^ int.tryParse(blockPart2, radix: 16)!).toRadixString(16);
      DES3 desECB = DES3(key: hex.decode(KeyHelper.CREDIT_CARD_PIN_BLOCK_KEY), mode: DESMode.ECB);
      encrypted = desECB.encrypt(hex.decode(finalBlock.padLeft(16, '0')));
      return hex.encode(encrypted).substring(0, 16).toUpperCase();
    } catch (e) {
      return '';
    }
  }

  static Map<String, dynamic> encryptRequest(Map<String, dynamic> request) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    try {
      Tuple2 dataPair = _finalDataEncrypt(jsonEncode(request));

      ///encrypted data
      data['data'] = dataPair.item2;

      /// encrypted key
      data['data1'] = dataPair.item1;

      debugPrint('data1 ==>');
      debugPrint('Encrypted key ' + dataPair.item1.toString());
      debugPrint('data ==>');
      debugPrint('Encrypted request ' + dataPair.item2.toString());
    } catch (e) {}
    return data;
  }

  ///AES encryption
  static Tuple2<String, String> _finalDataEncrypt(String data) {
    String randomKey = _generateRandomKey();
    Uint8List random = encrypt.Key.fromBase64(base64Encode(utf8.encode(randomKey))).bytes;
    var key = encrypt.Key(random);
    String encryptedKey = _encryptPublicKey(key);
    String encryptedData = _encryptRequestData(data, randomKey);
    return Tuple2(encryptedKey, encryptedData);
  }

  static String _generateRandomKey() {
    const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';

    Random _rnd = Random();
    var randomKey = String.fromCharCodes(
        Iterable.generate(16, (value) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

    return randomKey.toString().length > 16 ? randomKey.toString().substring(0, 16) : randomKey.toString();
  }

  ///RSA encryption
  static String _encryptPublicKey(encrypt.Key key) {
    /// FROM BACKEND PUBLIC KEY

    var serverPublicKey =
        //"MIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAiEHA5NjFmyC6dw84pzbpIzhXqH5VjD/fyFBko4z27iD8ZgQ5jzWs4wEC1XnCrYbKdmys+82P8oY38gEJxLcZsjuyYuy64s/gOD173sh054gYqhds9lNT/93KrEjhBUFpGUi+fq3PFCh2qrxd/9XaiMLcmg8y1UuCWKVW+JQCpwaLGK74xdmumnpfzvKHEzAIW3Bgn1wJZAPwMwcMz+uSY9afer4mCTfRRheisAlOMRgq7sN5J21Fxs7KlhSpvDlLbUsUuZ+nsbWjRStlahAHbumoZjiqJmvgY5iu+k6YJyciZYWv2IzL1IZ3plJ7O/SujdEIDL+oJfsVMn63veVZeAT6kxM9itsepINci4MlGlNhwzncpGkOQJeMBRVIbkF4D2Oa/oHRv+N+Olcdw+6Bw3C1bYXZOhB3jYZL6vhAgxcJIMpnGHWItWftm3Rll5nbxoKMHJPVg2ig3kf2Fkbe //7FK3WwiiAsB24rf2jIExx+oFPT8cz68cKBmMxlMzpOTDLvsdGewye6Gszefzvudwx+NQvvpepKoMrwSvDvW0WYEVFisrRKzrdcZ+a+iJRzfdBXubgvoLfBMl8tKf2lb2B+GzKVDH6pYnGpCieHKRxgU7ETadVkpXp8GifzKmbwqqSoZcr/Ebzy0dCM0sGVC00K7ZzmJhM5jBdC5Zj2/2MCAwEAAQ==";
        "MIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAiEHA5NjFmyC6dw84pzbpIzhXqH5VjD/fyFBko4z27iD8ZgQ5jzWs4wEC1XnCrYbKdmys+82P8oY38gEJxLcZsjuyYuy64s/gOD173sh054gYqhds9lNT/93KrEjhBUFpGUi+fq3PFCh2qrxd/9XaiMLcmg8y1UuCWKVW+JQCpwaLGK74xdmumnpfzvKHEzAIW3Bgn1wJZAPwMwcMz+uSY9afer4mCTfRRheisAlOMRgq7sN5J21Fxs7KlhSpvDlLbUsUuZ+nsbWjRStlahAHbumoZjiqJmvgY5iu+k6YJyciZYWv2IzL1IZ3plJ7O/SujdEIDL+oJfsVMn63veVZeAT6kxM9itsepINci4MlGlNhwzncpGkOQJeMBRVIbkF4D2Oa/oHRv+N+Olcdw+6Bw3C1bYXZOhB3jYZL6vhAgxcJIMpnGHWItWftm3Rll5nbxoKMHJPVg2ig3kf2Fkbe//7FK3WwiiAsB24rf2jIExx+oFPT8cz68cKBmMxlMzpOTDLvsdGewye6Gszefzvudwx+NQvvpepKoMrwSvDvW0WYEVFisrRKzrdcZ+a+iJRzfdBXubgvoLfBMl8tKf2lb2B+GzKVDH6pYnGpCieHKRxgU7ETadVkpXp8GifzKmbwqqSoZcr/Ebzy0dCM0sGVC00K7ZzmJhM5jBdC5Zj2/2MCAwEAAQ==";

    ///RSA encrypt
    final encrypter = encrypt.Encrypter(encrypt.RSA(
        publicKey: RsaKeyHelper().parsePublicKeyFromPem(serverPublicKey),
        encoding: encrypt.RSAEncoding.OAEP));

    return encrypter.encrypt(utf8.decode(key.bytes)).base64;
  }

  static String _encryptRequestData(String data, String key) {
    List<int> utfEncodedData = utf8.encode(data);
    Uint8List dataBytes = Uint8List.fromList(utfEncodedData);
    Uint8List keyBytes = Uint8List.fromList(key.codeUnits);
    KeyParameter keyParameter = KeyParameter(keyBytes);
    final cbcCipher = AESEngine()..init(true, keyParameter);
    final gcmCipher = GCMBlockCipher(cbcCipher);
    final params = AEADParameters(keyParameter, 128, Uint8List(16), Uint8List(0));
    gcmCipher.init(true, params);
    final encrypted = gcmCipher.process(dataBytes);
    return base64.encode(encrypted.toList());
  }
}