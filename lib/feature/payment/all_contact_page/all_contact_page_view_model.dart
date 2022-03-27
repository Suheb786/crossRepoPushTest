import 'package:domain/model/manage_contacts/beneficiary.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/feature/payment/all_contact_page/all_contact_page.dart';
import 'package:neo_bank/utils/extension/stream_extention.dart';
import 'package:neo_bank/utils/resource.dart';
import 'package:rxdart/rxdart.dart';

class AllContactPageViewModel extends BasePageViewModel {
  final AllContactArguments arguments;
  final TextEditingController contactSearchController = TextEditingController();

  /// beneficiary list response
  BehaviorSubject<Resource<List<Beneficiary>>> _searchBeneficiaryListResponse =
      BehaviorSubject();

  AllContactPageViewModel(this.arguments);

  Stream<Resource<List<Beneficiary>>> get getBeneficiaryListStream =>
      _searchBeneficiaryListResponse.stream;

  List<Beneficiary> allContacts = [];

  void setBeneficiaryList(List<Beneficiary> beneficiaryList) {
    allContacts = beneficiaryList;
    _searchBeneficiaryListResponse
        .safeAdd(Resource.success(data: beneficiaryList));
  }

  List<Beneficiary>? searchResult = [];

  void searchBeneficiary(String? searchText) {
    searchResult!.clear();
    List<Beneficiary>? beneficiaryList = allContacts;
    if (searchText!.isNotEmpty) {
      for (int i = 0; i < beneficiaryList.length; i++) {
        Beneficiary beneficiary = beneficiaryList[i];
        if (beneficiary.nickName != null) {
          if (beneficiary.nickName!
              .toLowerCase()
              .contains(searchText.toLowerCase())) {
            searchResult!.add(beneficiary);
          }
        }
      }
      _searchBeneficiaryListResponse
          .safeAdd(Resource.success(data: searchResult));
    } else {
      _searchBeneficiaryListResponse
          .safeAdd(Resource.success(data: allContacts));
    }
  }

  @override
  void dispose() {
    _searchBeneficiaryListResponse.close();
    super.dispose();
  }
}
