import 'package:domain/constants/enum/document_type_enum.dart';
import 'package:domain/usecase/upload_doc/upload_document_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class UserContactDetailsPageViewModel extends BasePageViewModel {
  ///--------------------------public-instance-valiables-------------------------------------///

  final UploadDocumentUseCase _uploadDocumentUseCase;

  ///---------------------------textEditing-controller----------------------------///

  TextEditingController editNameController = TextEditingController();
  TextEditingController editEmailController = TextEditingController();
  TextEditingController editIbanController = TextEditingController();

  ///-----------------------------upload profile---------------------------------///
  PublishSubject<UploadDocumentUseCaseParams> _uploadProfilePhotoRequest = PublishSubject();
  PublishSubject<String> _uploadProfilePhotoResponse = PublishSubject();

  Stream<String> get uploadProfilePhotoStream => _uploadProfilePhotoResponse.stream;

  ///---------------------------selected image subject----------------------------///
  final BehaviorSubject<String> _selectedImageSubject = BehaviorSubject.seeded('');

  Stream<String> get selectedImageValue => _selectedImageSubject.stream;
  String selectedProfile = '';

  ///--------------------------public-other-methods-------------------------------------///

  bool visibleSaveButton() {
    if (editNameController.text != editEmailController.text ||
        editIbanController.text != editEmailController.text ||
        editEmailController.text != editIbanController.text) {
      return true;
    }

    return false;
  }

  void addImage(String image) {
    _selectedImageSubject.safeAdd(image);
  }

  void uploadProfilePhoto(DocumentTypeEnum type) {
    _uploadProfilePhotoRequest.safeAdd(UploadDocumentUseCaseParams(documentType: type));
  }

  ///--------------------------public-constructor-------------------------------------///

  UserContactDetailsPageViewModel(this._uploadDocumentUseCase) {
    _uploadProfilePhotoRequest.listen((value) {
      RequestManager(value, createCall: () => _uploadDocumentUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        if (event.status == Status.SUCCESS) {
          _uploadProfilePhotoResponse.safeAdd(event.data!);
        }
      });
    });
  }
}
