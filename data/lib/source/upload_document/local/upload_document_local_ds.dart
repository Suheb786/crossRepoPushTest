import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

import '../upload_document_datasource.dart';

class UploadDocumentLocalDSImpl extends UploadDocumentLocalDS {
  ImagePicker _imagePicker = ImagePicker();

  @override
  Future<String> clickDocumentImage(String cameraPhotoFile) async {
    // final pickedFile = await _imagePicker.pickImage(source: ImageSource.camera, imageQuality: 50);
    // if (pickedFile != null) {
    //   return pickedFile.path;
    // }
    return cameraPhotoFile;
  }

  @override
  Future<String> pickUploadDocument() async {
    List<String> supportedTypes = ['jpg', 'pdf', 'doc', 'png'];

    ///Trigger file picker with supported file types
    FilePickerResult? result = (await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: supportedTypes,
    ));

    if (result != null) {
      PlatformFile file = result.files.single;
      return file.path!;
    }
    return "";
  }

  @override
  Future<String> pickImage() async {
    XFile? image = await _imagePicker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      return image.path;
    }
    return "";
  }
}
