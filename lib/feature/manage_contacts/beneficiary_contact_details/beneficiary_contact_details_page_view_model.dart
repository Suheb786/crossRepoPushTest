import 'package:domain/constants/enum/document_type_enum.dart';
import 'package:domain/model/manage_contacts/beneficiary.dart';
import 'package:domain/usecase/manage_contacts/delete_beneficiary_usecase.dart';
import 'package:domain/usecase/manage_contacts/remove_benificiary_profile_usecase.dart';
import 'package:domain/usecase/manage_contacts/update_beneficiary_usecase.dart';
import 'package:domain/usecase/manage_contacts/upload_beneficiary_profile_image_usecase.dart';
import 'package:domain/usecase/upload_doc/upload_document_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/main/app_viewmodel.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/navgition_type.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class BeneficiaryContactDetailsPageViewModel extends BasePageViewModel {
  ///--------------------------public-instance-valiables-------------------------------------///

  final UploadDocumentUseCase _uploadDocumentUseCase;
  final DeleteBeneficiaryUseCase _deleteBeneficiaryUseCase;
  final UpdateBeneficiaryUseCase _updateBeneficiaryUseCase;
  final UploadBeneficiaryProfileImageUseCase _uploadBeneficiaryProfileImageUseCase;
  final RemoveBeneficiaryProfileImageUseCase _removeBeneficiaryProfileImageUseCase;
  final Beneficiary argument;

  ///---------------------------textEditing-controller----------------------------///
  TextEditingController nickNameController = TextEditingController();
  FocusNode nickNameFocus = FocusNode();

  ///-----------------------------Delete Beneficiary---------------------------------///
  PublishSubject<DeleteBeneficiaryUseCaseParams> _deleteBeneficiaryRequest = PublishSubject();
  PublishSubject<String> _deleteBeneficiaryResponse = PublishSubject();

  Stream<String> get _deleteBeneficiaryStream => _deleteBeneficiaryResponse.stream;

  ///-----------------------update-beneficiary---------------------------///
  PublishSubject<UpdateBeneficiaryUseCaseParams> _updateBeneficiaryRequest = PublishSubject();
  PublishSubject<bool> _updateBeneficiaryResponse = PublishSubject();

  Stream<bool> get updateBeneficiaryStream => _updateBeneficiaryResponse.stream;

  ///-----------------------------upload profile---------------------------------///
  PublishSubject<UploadDocumentUseCaseParams> _uploadProfilePhotoRequest = PublishSubject();
  PublishSubject<String> _uploadProfilePhotoResponse = PublishSubject();

  Stream<String> get uploadProfilePhotoStream => _uploadProfilePhotoResponse.stream;

  ///---------------------------selected image subject----------------------------///
  final BehaviorSubject<String> _selectedImageSubject = BehaviorSubject.seeded('');

  Stream<String> get selectedImageValue => _selectedImageSubject.stream;

  ///---------------------------selected image subject----------------------------///
  final PublishSubject<UploadBeneficiaryProfileImageUseCaseParams> _updateProfileImageRequestSubject =
      PublishSubject();

  // final BehaviorSubject<bool> updateProfileImageResponseSubject = BehaviorSubject();
  //
  // Stream<bool> get updateProfileImageStream => updateProfileImageResponseSubject.stream;

  ///---------------------------selected image subject----------------------------///
  final PublishSubject<RemoveBeneficiaryProfileImageUseCaseParams> _removeProfileImageRequestSubject =
      PublishSubject();

  // final BehaviorSubject<bool> removeProfileImageResponseSubject = BehaviorSubject();
  //
  // Stream<bool> get removeProfileImageStream => removeProfileImageResponseSubject.stream;

  String selectedProfile = '';

  // bool isEditable;

  ValueNotifier<bool> nameEditableNotifier = ValueNotifier(true);

  NavigationType? navigationType;

  ///--------------------------public-other-methods-------------------------------------///

  void addImage(String image) {
    // image update api here..
    _updateProfileImageRequestSubject.safeAdd(UploadBeneficiaryProfileImageUseCaseParams(
      beneficiaryId: argument.id!,
      filePath: image,
      beneType: navigationType == NavigationType.REQUEST_MONEY ? 'RTP' : 'SM',
    ));
  }

  void uploadProfilePhoto(DocumentTypeEnum type) {
    _uploadProfilePhotoRequest.safeAdd(UploadDocumentUseCaseParams(documentType: type));
  }

  void deleteBeneficiary() {
    _deleteBeneficiaryRequest.safeAdd(DeleteBeneficiaryUseCaseParams(
        beneficiaryId: argument.id!,
        beneType: navigationType == NavigationType.REQUEST_MONEY ? 'RTP' : 'SM'));
  }

  void updateBeneficiary() {
    _updateBeneficiaryRequest.safeAdd(UpdateBeneficiaryUseCaseParams(
        beneficiaryId: argument.id!,
        nickName: nickNameController.text,
        beneType: navigationType == NavigationType.REQUEST_MONEY ? 'RTP' : 'SM'));
  }

  ///--------------------------public-constructor-------------------------------------///

  BeneficiaryContactDetailsPageViewModel(
      this._uploadDocumentUseCase,
      this._deleteBeneficiaryUseCase,
      this._updateBeneficiaryUseCase,
      this._uploadBeneficiaryProfileImageUseCase,
      this._removeBeneficiaryProfileImageUseCase,
      this.argument) {
    nickNameController.text = argument.nickName!;
    _uploadProfilePhotoRequest.listen((value) {
      RequestManager(value, createCall: () => _uploadDocumentUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        if (event.status == Status.SUCCESS) {
          _uploadProfilePhotoResponse.safeAdd(event.data!);
        }
      });
    });

    _deleteBeneficiaryRequest.listen((value) {
      RequestManager(value, createCall: () => _deleteBeneficiaryUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        if (event.status == Status.SUCCESS) {
          Navigator.pop(appLevelKey.currentContext!);
        }
      });
    });

    _updateBeneficiaryRequest.listen((value) {
      RequestManager(value, createCall: () => _updateBeneficiaryUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        if (event.status == Status.SUCCESS) {}
      });
    });

    _updateProfileImageRequestSubject.listen((value) {
      RequestManager(value, createCall: () => _uploadBeneficiaryProfileImageUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        if (event.status == Status.SUCCESS) {
          _selectedImageSubject.safeAdd(selectedProfile);
        }
      });
    });

    _removeProfileImageRequestSubject.listen((value) {
      RequestManager(value, createCall: () => _removeBeneficiaryProfileImageUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        if (event.status == Status.SUCCESS) {
          selectedProfile = '';
          argument.imageUrl = '';
          _selectedImageSubject.safeAdd(selectedProfile);
        }
      });
    });
  }

  removeImage() {
    _removeProfileImageRequestSubject.safeAdd(RemoveBeneficiaryProfileImageUseCaseParams(
      beneficiaryId: argument.id!,
      beneType: navigationType == NavigationType.REQUEST_MONEY ? 'RTP' : 'SM',
    ));
  }

  toggleNickName() {
    nameEditableNotifier.value = !nameEditableNotifier.value;
    if (!nameEditableNotifier.value) {
      FocusScope.of(appLevelKey.currentContext!).requestFocus(nickNameFocus);
    }
  }

  setNickNameReadOnly() {
    nameEditableNotifier.value = true;
    updateBeneficiary();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
