import 'package:domain/constants/enum/document_type_enum.dart';
import 'package:domain/model/manage_contacts/beneficiary.dart';
import 'package:domain/usecase/upload_doc/upload_document_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/main/app_viewmodel.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class BeneficiaryContactDetailsPageViewModel extends BasePageViewModel {
  ///--------------------------public-instance-valiables-------------------------------------///

  final UploadDocumentUseCase _uploadDocumentUseCase;
  final Beneficiary argument;

  ///---------------------------textEditing-controller----------------------------///

  TextEditingController editNameController = TextEditingController();
  TextEditingController editEmailController = TextEditingController();
  TextEditingController editIbanController = TextEditingController();
  TextEditingController nickNameController = TextEditingController();
  FocusNode nickNameFocus = FocusNode();

  ///-----------------------------upload profile---------------------------------///
  PublishSubject<UploadDocumentUseCaseParams> _uploadProfilePhotoRequest = PublishSubject();
  PublishSubject<String> _uploadProfilePhotoResponse = PublishSubject();

  Stream<String> get uploadProfilePhotoStream => _uploadProfilePhotoResponse.stream;

  ///---------------------------selected image subject----------------------------///
  final BehaviorSubject<String> _selectedImageSubject = BehaviorSubject.seeded('');

  Stream<String> get selectedImageValue => _selectedImageSubject.stream;
  String selectedProfile = '';

  ///---------------------------Request Money--------------------------------///
  PublishSubject<bool> _favouriteAsRequestMoneySubject = PublishSubject();

  Stream<bool> get favouriteAsRequestMoneyStream => _favouriteAsRequestMoneySubject.stream;

  ///---------------------------Send Money--------------------------------///
  PublishSubject<bool> _favouriteAsSendMoneySubject = PublishSubject();

  Stream<bool> get favouriteAsSendMoneyStream => _favouriteAsSendMoneySubject.stream;

  // bool isEditable;

  ValueNotifier<bool> nameEditableNotifier = ValueNotifier(true);

  ///--------------------------public-other-methods-------------------------------------///

  void toggleFavouriteAsSendMoney(bool value) {
    _favouriteAsSendMoneySubject.safeAdd(value);
  }

  void toggleFavouriteAsRequestMoney(bool value) {
    _favouriteAsRequestMoneySubject.safeAdd(value);
  }

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

  BeneficiaryContactDetailsPageViewModel(this._uploadDocumentUseCase, this.argument) {
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
  }

  @override
  void dispose() {
    _favouriteAsSendMoneySubject.close();
    _favouriteAsRequestMoneySubject.close();
    super.dispose();
  }
}
