import 'dart:convert';
import 'dart:io' as Io;

class ImageUtils {
  ImageUtils._();

  /// returns  base64  string
  static String convertToBase64(String image) {
    final bytes = Io.File(image).readAsBytesSync();
    String baseImage64 = base64Encode(bytes);
    return baseImage64;
  }
}
