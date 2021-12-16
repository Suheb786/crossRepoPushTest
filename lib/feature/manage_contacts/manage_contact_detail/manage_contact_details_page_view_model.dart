import 'package:domain/constants/enum/document_type_enum.dart';
import 'package:domain/usecase/upload_doc/upload_document_usecase.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/feature/manage_contacts/manage_contacts_list/manage_contacts_list_page_view_model.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:rxdart/rxdart.dart';

class ManageContactDetailsPageViewModel extends BasePageViewModel {
  final UploadDocumentUseCase _uploadDocumentUseCase;

  final ContactsListModel contactsListModel;

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

  ///upload profile
  PublishSubject<UploadDocumentUseCaseParams> _uploadProfilePhotoRequest =
      PublishSubject();

  PublishSubject<String> _uploadProfilePhotoResponse = PublishSubject();

  Stream<String> get uploadProfilePhotoStream =>
      _uploadProfilePhotoResponse.stream;

  /// show save button visibility
  BehaviorSubject<bool> _showSaveButtonSubject = BehaviorSubject.seeded(false);

  Stream<bool> get showSaveButtonStream => _showSaveButtonSubject.stream;

  ManageContactDetailsPageViewModel(
      this._uploadDocumentUseCase, this.contactsListModel) {
    _uploadProfilePhotoRequest.listen((value) {
      RequestManager(value,
              createCall: () => _uploadDocumentUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        _uploadProfilePhotoResponse.safeAdd(event.data!);
      });
    });
  }

  void uploadProfilePhoto(DocumentTypeEnum type) {
    _uploadProfilePhotoRequest
        .safeAdd(UploadDocumentUseCaseParams(documentType: type));
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
