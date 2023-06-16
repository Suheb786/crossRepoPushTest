import 'package:domain/constants/enum/document_type_enum.dart';
import 'package:domain/usecase/manage_contacts/delete_beneficiary_usecase.dart';
import 'package:domain/usecase/manage_contacts/remove_benificiary_profile_usecase.dart';
import 'package:domain/usecase/manage_contacts/update_beneficiary_usecase.dart';
import 'package:domain/usecase/manage_contacts/upload_beneficiary_profile_image_usecase.dart';
import 'package:domain/usecase/upload_doc/upload_document_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/navgition_type.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class BeneficiaryContactDetailsPageViewModel extends BasePageViewModel {
  ///--------------------------public-instance-valiables-------------------------------------///

  final UploadDocumentUseCase _uploadDocumentUseCase;
  final DeleteBeneficiaryUseCase _deleteBeneficiaryUseCase;
  final UpdateBeneficiaryUseCase _updateBeneficiaryUseCase;
  final UploadBeneficiaryProfileImageUseCase _uploadBeneficiaryProfileImageUseCase;
  final RemoveBeneficiaryProfileImageUseCase _removeBeneficiaryProfileImageUseCase;
  final dynamic argument;

  ///---------------------------textEditing-controller----------------------------///
  TextEditingController nickNameController = TextEditingController();
  FocusNode nickNameFocus = FocusNode();

  ///-----------------------------Delete Beneficiary---------------------------------///
  PublishSubject<DeleteBeneficiaryUseCaseParams> _deleteBeneficiaryRequest = PublishSubject();
  PublishSubject<Resource<bool>> _deleteBeneficiaryResponse = PublishSubject();

  Stream<Resource<bool>> get deleteBeneficiaryStream => _deleteBeneficiaryResponse.stream;

  ///-----------------------update-beneficiary---------------------------///
  PublishSubject<UpdateBeneficiaryUseCaseParams> _updateBeneficiaryRequest = PublishSubject();
  PublishSubject<Resource<bool>> _updateBeneficiaryResponse = PublishSubject();

  Stream<Resource<bool>> get updateBeneficiaryStream => _updateBeneficiaryResponse.stream;

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

  ///---------------------------selected image subject----------------------------///
  final PublishSubject<RemoveBeneficiaryProfileImageUseCaseParams> _removeProfileImageRequestSubject =
      PublishSubject();

  String selectedProfile = '';

  final BehaviorSubject<bool> _nameEditableNotifierSubject = BehaviorSubject.seeded(true);

  Stream<bool> get nameEditableNotifierStream => _nameEditableNotifierSubject.stream;

  NavigationType? navigationType;

  bool isUpdateProfile = false;

  ///--------------------------public-other-methods-------------------------------------///

  void addImage(String image) {
    /// image update api here..
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
          isUpdateProfile = true;
          _uploadProfilePhotoResponse.safeAdd(event.data!);
        }
      });
    });

    _deleteBeneficiaryRequest.listen((value) {
      RequestManager(value, createCall: () => _deleteBeneficiaryUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _deleteBeneficiaryResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showToastWithError(event.appError!);
        }
      });
    });

    _updateBeneficiaryRequest.listen((value) {
      RequestManager(value, createCall: () => _updateBeneficiaryUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _updateBeneficiaryResponse.safeAdd(event);
        if (event.status == Status.SUCCESS) {
          isUpdateProfile = true;
        } else if (event.status == Status.ERROR) {
          showToastWithError(event.appError!);
        }
      });
    });

    _updateProfileImageRequestSubject.listen((value) {
      RequestManager(value, createCall: () => _uploadBeneficiaryProfileImageUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        if (event.status == Status.SUCCESS) {
          isUpdateProfile = true;
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
          isUpdateProfile = true;
          selectedProfile = '';
          argument.image = '';
          _selectedImageSubject.safeAdd(selectedProfile);
        }
      });
    });
  }

  removeImage() {
    _removeProfileImageRequestSubject.safeAdd(RemoveBeneficiaryProfileImageUseCaseParams(
      beneficiaryId: argument.id ?? '',
      beneType: navigationType == NavigationType.REQUEST_MONEY ? 'RTP' : 'SM',
    ));
  }

  toggleNickName(BuildContext context) {
    _nameEditableNotifierSubject.value = !_nameEditableNotifierSubject.value;
    if (!_nameEditableNotifierSubject.value) {
      FocusScope.of(context).requestFocus(nickNameFocus);
    } else {
      setNickNameReadOnly();
    }
  }

  setNickNameReadOnly() {
    _nameEditableNotifierSubject.safeAdd(true);
    _updateBeneficiaryRequest.safeAdd(UpdateBeneficiaryUseCaseParams(
        beneficiaryId: argument.id ?? '',
        nickName: nickNameController.text,
        beneType: navigationType == NavigationType.REQUEST_MONEY ? 'RTP' : 'SM'));
  }

  @override
  void dispose() {
    super.dispose();
  }
}
