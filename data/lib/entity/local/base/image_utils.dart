import 'dart:convert';
import 'dart:io' as Io;
import 'dart:io';
import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';

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

  ///decode base64 pdf string
  static Future<File> pdfFileFromBase64String(
      String base64PdfString, String title) async {
    var bytes = base64Decode(base64PdfString.replaceAll('\n', ''));

    ///TODO:write on output directory
    final output = await getTemporaryDirectory();
    final file = File("${output.path}/$title.pdf");
    await file.writeAsBytes(bytes.buffer.asUint8List());
    return file;
  }
}
