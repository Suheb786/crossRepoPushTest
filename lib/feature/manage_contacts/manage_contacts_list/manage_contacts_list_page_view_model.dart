import 'package:domain/usecase/manage_contacts/get_beneficiary_usecase.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/request_manager.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:neo_bank/utils/status.dart';
import 'package:rxdart/rxdart.dart';

class ManageContactListPageViewModel extends BasePageViewModel {
  final GetBeneficiaryUseCase _getBeneficiaryUseCase;
  final TextEditingController contactSearchController = TextEditingController();

  final List<ContactsListModel> contactList = [
    ContactsListModel(
        imageUrl: '${AssetUtils.drawable}dummy_profile1.png',
        name: 'Areef',
        bankName: 'Housing Bank Jordan',
        accounHolderName: 'Areef Rehan',
        iban: 'ABC000012341234123819241213123',
        purpose: 'Personal',
        purposeDetails: 'Transfer'),
    ContactsListModel(
        imageUrl: '${AssetUtils.drawable}dummy_profile2.png',
        name: 'Asheeta (Mom)',
        bankName: 'Housing Bank Jordan',
        accounHolderName: 'Asheeta Rehan',
        iban: 'ABC000012341234123819241213123',
        purpose: 'Personal',
        purposeDetails: 'Transfer'),
    ContactsListModel(
        imageUrl: '${AssetUtils.drawable}dummy_profile3.png',
        name: 'Badr',
        bankName: 'Housing Bank Jordan',
        accounHolderName: 'Badr',
        iban: 'ABC000012341234123819241213123',
        purpose: 'Personal',
        purposeDetails: 'Transfer'),
    ContactsListModel(
        name: 'Heida Raful',
        bankName: 'Housing Bank Jordan',
        accounHolderName: 'Heida Raful',
        iban: 'ABC000012341234123819241213123',
        purpose: 'Personal',
        purposeDetails: 'Transfer'),
    ContactsListModel(
        name: 'Ilya Miraz',
        bankName: 'Housing Bank Jordan',
        accounHolderName: 'Ilya Miraz',
        iban: 'ABC000012341234123819241213123',
        purpose: 'Personal',
        purposeDetails: 'Transfer'),
    ContactsListModel(
        name: 'Samir Abdoulla',
        bankName: 'Housing Bank Jordan',
        accounHolderName: 'Samir Abdoulla',
        iban: 'ABC000012341234123819241213123',
        purpose: 'Personal',
        purposeDetails: 'Transfer'),
  ];

  ///get beneficiary list
  PublishSubject<GetBeneficiaryUseCaseParams> _getBeneficiaryListRequest =
      PublishSubject();

  PublishSubject<Resource<bool>> _getBeneficiaryListResponse = PublishSubject();

  Stream<Resource<bool>> get getBeneficiaryListStream =>
      _getBeneficiaryListResponse.stream;

  ManageContactListPageViewModel(this._getBeneficiaryUseCase) {
    _getBeneficiaryListRequest.listen((value) {
      RequestManager(value,
              createCall: () => _getBeneficiaryUseCase.execute(params: value))
          .asFlow()
          .listen((event) {
        updateLoader();
        _getBeneficiaryListResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showErrorState();
          showToastWithError(event.appError!);
        }
      });
    });
  }

  void getBeneficiaryList() {
    _getBeneficiaryListRequest.safeAdd(GetBeneficiaryUseCaseParams());
  }

  @override
  void dispose() {
    _getBeneficiaryListRequest.close();
    _getBeneficiaryListResponse.close();
    super.dispose();
  }
}

class ContactsListModel {
  final String? beneficiaryId;
  final String? imageUrl;
  final String? name;
  final String? iban;
  final String? accounHolderName;
  final String? bankName;
  final String? purpose;
  final String? purposeDetails;

  ContactsListModel(
      {this.beneficiaryId: "",
      this.imageUrl: "",
      this.name: "",
      this.bankName,
      this.iban,
      this.accounHolderName,
      this.purpose,
      this.purposeDetails});
}
