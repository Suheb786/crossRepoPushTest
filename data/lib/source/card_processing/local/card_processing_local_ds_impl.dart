import 'dart:convert';

import 'package:convert/convert.dart';
import 'package:dart_des/dart_des.dart';
import 'package:data/source/card_processing/card_processing_data_source.dart';
import 'package:string_validator/string_validator.dart';

class CardProcessingLocalDsImpl with CardProcessingLocalDs {
  List<int> cardKey =
      hex.decode('0123456789ABCDEFFEDCBA98765432100123456789ABCDEF');
  List<int> pinKey = hex.decode('AB9B545DAEC2ABC74FB90D15CE04B997');
  @override
  String decryptCard({required String cardNo}) {
    final List<int> decrypted;
    DES3 desECB = DES3(key: cardKey, mode: DESMode.ECB);
    decrypted = desECB.decrypt(
        isHexadecimal(cardNo) ? hex.decode(cardNo) : base64.decode(cardNo));
    return String.fromCharCodes(decrypted).replaceAll(RegExp(r'[^0-9]'), '');
  }

  @override
  String generateBlockPin({required String cardNo, required String pinCode}) {
    final List<int> encrypted;
    String blockPart1 = "0${pinCode.length}$pinCode";
    blockPart1 = blockPart1.padRight(16, 'F');
    String blockPart2 = cardNo.substring(3, cardNo.length - 1).padLeft(16, '0');
    String finalBlock = (int.tryParse(blockPart1, radix: 16)! ^
            int.tryParse(blockPart2, radix: 16)!)
        .toRadixString(16);
    DES3 desECB = DES3(key: pinKey, mode: DESMode.ECB);
    encrypted = desECB.encrypt(hex.decode(finalBlock.padLeft(16, '0')));
    return hex.encode(encrypted).substring(0, 16);
  }
}
