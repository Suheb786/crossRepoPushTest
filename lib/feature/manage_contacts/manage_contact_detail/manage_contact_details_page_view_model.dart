import 'package:domain/constants/enum/document_type_enum.dart';
import 'package:domain/model/manage_contacts/beneficiary.dart';
import 'package:domain/usecase/manage_contacts/delete_beneficiary_usecase.dart';
import 'package:domain/usecase/manage_contacts/update_beneficiary_usecase.dart';
import 'package:domain/usecase/manage_contacts/upload_beneficiary_profile_image_usecase.dart';
import 'package:domain/usecase/upload_doc/upload_document_usecase.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class ManageContactDetailsPageViewModel extends BasePageViewModel {
  final UploadDocumentUseCase _uploadDocumentUseCase;

  final Beneficiary beneficiary;

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

  UpdateType updateType = UpdateType.none;

  ManageContactDetailsPageViewModel(
      this._uploadDocumentUseCase,
      this.beneficiary,
      this._updateBeneficiaryUseCase,
      this._deleteBeneficiaryUseCase,
      this._uploadBeneficiaryProfileImageUseCase) {
    _uploadProfilePhotoRequest.listen((value) {
      RequestManager(value,
              createCall: () => _uploadDocumentUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
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
    if (updateType == UpdateType.details) {
      _updateBeneficiaryRequest.safeAdd(UpdateBeneficiaryUseCaseParams(
          beneficiaryId: beneficiary.id!,
          nickName: nickNameController.text,
          purposeDetails: purposeDetailsController.text,
          purpose: purposeController.text));
    } else {
      uploadBeneficiaryImageProfile();
    }
  }

  void deleteBeneficiary() {
    _deleteBeneficiaryRequest.safeAdd(DeleteBeneficiaryUseCaseParams(
      beneficiaryId: beneficiary.id!,
    ));
  }

  void uploadBeneficiaryImageProfile() {
    _uploadBeneficiaryProfileImageRequest
        .safeAdd(UploadBeneficiaryProfileImageUseCaseParams(
      beneficiaryId: beneficiary.id!,
      filePath: selectedProfile,
    ));
  }

  void addImage(String image) {
    _selectedImageSubject.safeAdd(image);
  }

  void setData() {
    nickNameController.text = beneficiary.nickName!;
    ibanController.text = beneficiary.iban!;
    accountHolderNameController.text = beneficiary.fullName!;
    bankNameController.text = beneficiary.bankName!;
    purposeController.text = beneficiary.purpose!;
    purposeDetailsController.text = beneficiary.purposeDetails!;
  }

  void showSaveButton() {
    bool show = false;
    if (nickNameController.text != beneficiary.nickName ||
        purposeController.text != beneficiary.purpose ||
        purposeDetailsController.text != beneficiary.purposeDetails ||
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

enum UpdateType { image, details, none }
