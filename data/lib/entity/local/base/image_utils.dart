import 'dart:convert';
import 'dart:io' as Io;
import 'dart:typed_data';

class ImageUtils {
  ImageUtils._();

  /// returns  base64  string
  static String convertToBase64(String image) {
    final bytes = Io.File(image).readAsBytesSync();
    String baseImage64 = base64Encode(bytes);
    return baseImage64;
  }

  /// decode  base64  imgae
  static Uint8List dataFromBase64String(String base64String) {
    return base64Decode(base64String);
  }
}
