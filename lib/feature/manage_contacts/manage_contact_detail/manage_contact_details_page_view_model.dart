import 'package:domain/constants/enum/document_type_enum.dart';
import 'package:domain/usecase/manage_contacts/delete_beneficiary_usecase.dart';
import 'package:domain/usecase/manage_contacts/update_beneficiary_usecase.dart';
import 'package:domain/usecase/manage_contacts/upload_beneficiary_profile_image_usecase.dart';
import 'package:domain/usecase/upload_doc/upload_document_usecase.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/feature/manage_contacts/manage_contacts_list/manage_contacts_list_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class ManageContactDetailsPageViewModel extends BasePageViewModel {
  final UploadDocumentUseCase _uploadDocumentUseCase;

  final ContactsListModel contactsListModel;

  final UpdateBeneficiaryUseCase _updateBeneficiaryUseCase;

  final DeleteBeneficiaryUseCase _deleteBeneficiaryUseCase;

  final UploadBeneficiaryProfileImageUseCase
      _uploadBeneficiaryProfileImageUseCase;

  ///controllers and keys
  TextEditingController nickNameController = new TextEditingController();
  TextEditingController ibanController = new TextEditingController();
  TextEditingController accountHolderNameController =
      new TextEditingController();
  TextEditingController bankNameController = new TextEditingController();
  TextEditingController purposeController = new TextEditingController();
  TextEditingController purposeDetailsController = new TextEditingController();

  ///selected image subject
  final BehaviorSubject<String> _selectedImageSubject =
      BehaviorSubject.seeded('');

  Stream<String> get selectedImageValue => _selectedImageSubject.stream;

  String selectedProfile = '';

  ///update beneficiary
  PublishSubject<UpdateBeneficiaryUseCaseParams> _updateBeneficiaryRequest =
      PublishSubject();

  PublishSubject<Resource<bool>> _updateBeneficiaryResponse = PublishSubject();

  Stream<Resource<bool>> get updateBeneficiaryStream =>
      _updateBeneficiaryResponse.stream;

  ///get profile photo
  PublishSubject<UploadDocumentUseCaseParams> _uploadProfilePhotoRequest =
      PublishSubject();

  PublishSubject<String> _uploadProfilePhotoResponse = PublishSubject();

  Stream<String> get uploadProfilePhotoStream =>
      _uploadProfilePhotoResponse.stream;

  /// show save button visibility
  BehaviorSubject<bool> _showSaveButtonSubject = BehaviorSubject.seeded(false);

  Stream<bool> get showSaveButtonStream => _showSaveButtonSubject.stream;

  ///delete beneficiary
  PublishSubject<DeleteBeneficiaryUseCaseParams> _deleteBeneficiaryRequest =
      PublishSubject();

  PublishSubject<Resource<bool>> _deleteBeneficiaryResponse = PublishSubject();

  Stream<Resource<bool>> get deleteBeneficiaryStream =>
      _deleteBeneficiaryResponse.stream;

  ///upload beneficiary profile image
  PublishSubject<UploadBeneficiaryProfileImageUseCaseParams>
      _uploadBeneficiaryProfileImageRequest = PublishSubject();

  PublishSubject<Resource<bool>> _uploadBeneficiaryProfileImageResponse =
      PublishSubject();

  Stream<Resource<bool>> get uploadBeneficiaryProfileImageStream =>
      _uploadBeneficiaryProfileImageResponse.stream;

  ManageContactDetailsPageViewModel(
      this._uploadDocumentUseCase,
      this.contactsListModel,
      this._updateBeneficiaryUseCase,
      this._deleteBeneficiaryUseCase,
      this._uploadBeneficiaryProfileImageUseCase) {
    _uploadProfilePhotoRequest.listen((value) {
      RequestManager(value,
              createCall: () => _uploadDocumentUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        _uploadProfilePhotoResponse.safeAdd(event.data!);
      });
    });

    _updateBeneficiaryRequest.listen((value) {
      RequestManager(value,
              createCall: () =>
                  _updateBeneficiaryUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _updateBeneficiaryResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        }
      });
    });

    _deleteBeneficiaryRequest.listen((value) {
      RequestManager(value,
              createCall: () =>
                  _deleteBeneficiaryUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _deleteBeneficiaryResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        }
      });
    });

    _uploadBeneficiaryProfileImageRequest.listen((value) {
      RequestManager(value,
              createCall: () =>
                  _uploadBeneficiaryProfileImageUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _uploadBeneficiaryProfileImageResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        }
      });
    });
  }

  void uploadProfilePhoto(DocumentTypeEnum type) {
    _uploadProfilePhotoRequest
        .safeAdd(UploadDocumentUseCaseParams(documentType: type));
  }

  void updateBeneficiary() {
    _updateBeneficiaryRequest.safeAdd(UpdateBeneficiaryUseCaseParams(
        beneficiaryId: contactsListModel.beneficiaryId!,
        nickName: contactsListModel.name!,
        purposeDetails: contactsListModel.purposeDetails!,
        purpose: contactsListModel.purpose!));
  }

  void deleteBeneficiary() {
    _deleteBeneficiaryRequest.safeAdd(DeleteBeneficiaryUseCaseParams(
      beneficiaryId: contactsListModel.beneficiaryId!,
    ));
  }

  void uploadBeneficiaryImageProfile() {
    _uploadBeneficiaryProfileImageRequest
        .safeAdd(UploadBeneficiaryProfileImageUseCaseParams(
      beneficiaryId: contactsListModel.beneficiaryId!,
      filePath: selectedProfile,
    ));
  }

  void addImage(String image) {
    _selectedImageSubject.safeAdd(image);
  }

  void setData() {
    nickNameController.text = contactsListModel.name!;
    ibanController.text = contactsListModel.iban!;
    accountHolderNameController.text = contactsListModel.accounHolderName!;
    bankNameController.text = contactsListModel.bankName!;
    purposeController.text = contactsListModel.purpose!;
    purposeDetailsController.text = contactsListModel.purposeDetails!;
  }

  void showSaveButton() {
    bool show = false;
    if (nickNameController.text != contactsListModel.name ||
        purposeController.text != contactsListModel.purpose ||
        purposeDetailsController.text != contactsListModel.purposeDetails ||
        selectedProfile.isNotEmpty) {
      show = true;
    }
    _showSaveButtonSubject.safeAdd(show);
  }

  @override
  void dispose() {
    _selectedImageSubject.close();
    _uploadProfilePhotoRequest.close();
    _uploadProfilePhotoResponse.close();
    _showSaveButtonSubject.close();
    super.dispose();
  }
}
