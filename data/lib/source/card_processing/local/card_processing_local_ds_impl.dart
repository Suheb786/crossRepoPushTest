import 'dart:convert';

import 'package:convert/convert.dart';
import 'package:dart_des/dart_des.dart';
import 'package:data/source/card_processing/card_processing_data_source.dart';

class CardProcessingLocalDsImpl with CardProcessingLocalDs {
  List<int> key =
      hex.decode('0123456789ABCDEFFEDCBA98765432100123456789ABCDEF');
  @override
  String decryptCard({required String cardNo}) {
    final List<int> decrypted;
    DES3 desECB = DES3(key: key, mode: DESMode.ECB);
    decrypted = desECB.decrypt(base64.decode(cardNo));
    return String.fromCharCodes((decrypted));
  }

  @override
  String generateBlockPin({required String cardNo, required String pinCode}) {
    final List<int> encrypted;
    DES3 desECB = DES3(key: key, mode: DESMode.ECB);
    encrypted = desECB.encrypt(cardNo.codeUnits);
    return hex.encode(encrypted);
  }
}
