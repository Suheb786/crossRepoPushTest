import 'package:domain/constants/enum/document_type_enum.dart';
import 'package:domain/model/manage_contacts/beneficiary.dart';
import 'package:domain/usecase/manage_contacts/delete_beneficiary_usecase.dart';
import 'package:domain/usecase/manage_contacts/update_beneficiary_usecase.dart';
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
  String selectedProfile = '';

  // bool isEditable;

  ValueNotifier<bool> nameEditableNotifier = ValueNotifier(true);

  NavigationType? navigationType;

  ///--------------------------public-other-methods-------------------------------------///

  void addImage(String image) {
    _selectedImageSubject.safeAdd(image);
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

  BeneficiaryContactDetailsPageViewModel(this._uploadDocumentUseCase, this._deleteBeneficiaryUseCase,
      this._updateBeneficiaryUseCase, this.argument) {
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
  }

  removeImage() {
    _selectedImageSubject.value = "";
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
