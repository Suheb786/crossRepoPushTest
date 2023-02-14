import 'package:domain/constants/enum/document_type_enum.dart';
import 'package:domain/usecase/account_setting/get_profile_info/get_profile_info_usecase.dart';
import 'package:domain/usecase/account_setting/upload_profile_image/delete_profile_image_usecase.dart';
import 'package:domain/usecase/account_setting/upload_profile_image/upload_profile_image_usecase.dart';
import 'package:domain/usecase/upload_doc/upload_document_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class UserContactDetailsPageViewModel extends BasePageViewModel {
  ///--------------------------public-instance-valiables-------------------------------------///

  final UploadProfileImageUseCase _uploadProfileImageUseCase;

  ///---------------------------textEditing-controller----------------------------///

  TextEditingController editNameController = TextEditingController();
  TextEditingController editEmailController = TextEditingController();
  TextEditingController editIbanController = TextEditingController();

  ///-----------------------------upload profile---------------------------------///
  PublishSubject<UploadDocumentUseCaseParams> _uploadProfilePhotoRequest = PublishSubject();
  PublishSubject<String> _uploadProfilePhotoResponse = PublishSubject();

  Stream<String> get uploadProfilePhotoStream => _uploadProfilePhotoResponse.stream;

  ///--------------------------delete profile image usecase---------------------------///
  PublishSubject<DeleteProfileImageUseCaseParams> _deleteProfileImageRequest = PublishSubject();
  PublishSubject<Resource<bool>> _deleteProfileImageResponse = PublishSubject();
  Stream<Resource<bool>> get deleteProfileImageStream => _deleteProfileImageResponse.stream;

  ///----------------------------upload profile image------------------------------///
  PublishSubject<UploadProfileImageUseCaseParams> _uploadProfileImageRequest = PublishSubject();
  PublishSubject<Resource<bool>> _uploadProfileImageResponse = PublishSubject();
  Stream<Resource<bool>> get uploadProfileImageStream => _uploadProfileImageResponse.stream;

  ///---------------------------selected image subject----------------------------///
  final BehaviorSubject<String> _selectedImageSubject = BehaviorSubject.seeded('');
  Stream<String> get selectedImageValue => _selectedImageSubject.stream;

  ///-----------------------------get profile info-------------------------------///
  PublishSubject<GetProfileInfoUseCaseParams> _getProfileInfoRequest = PublishSubject();
  PublishSubject<Resource<bool>> _getProfileInfoResponse = PublishSubject();
  Stream<Resource<bool>> get getProfileInfoStream => _getProfileInfoResponse.stream;
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

  void deleteProfileImage(dynamic image) {
    if (image != null && image != '') {
      _deleteProfileImageRequest.safeAdd(DeleteProfileImageUseCaseParams());
    }
  }

  void uploadProfilePhoto(DocumentTypeEnum type) {
    _uploadProfilePhotoRequest.safeAdd(UploadDocumentUseCaseParams(documentType: type));
  }

  void uploadProfileImage() {
    _uploadProfileImageRequest.safeAdd(UploadProfileImageUseCaseParams(imagePath: selectedProfile));
  }

  void getProfileDetails() {
    _getProfileInfoRequest.safeAdd(GetProfileInfoUseCaseParams());
  }

  ///--------------------------public-constructor-------------------------------------///

  UserContactDetailsPageViewModel(this._uploadProfileImageUseCase) {
    _uploadProfileImageRequest.listen((value) {
      RequestManager(value, createCall: () => _uploadProfileImageUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _uploadProfileImageResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        }
      });
    });
  }
}
