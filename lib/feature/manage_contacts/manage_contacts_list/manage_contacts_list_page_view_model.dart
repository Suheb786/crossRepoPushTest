import 'package:flutter/material.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/asset_utils.dart';

class ManageContactListPageViewModel extends BasePageViewModel {
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
}

class ContactsListModel {
  final String? imageUrl;
  final String? name;
  final String? iban;
  final String? accounHolderName;
  final String? bankName;
  final String? purpose;
  final String? purposeDetails;

  ContactsListModel(
      {this.imageUrl: "",
      this.name: "",
      this.bankName,
      this.iban,
      this.accounHolderName,
      this.purpose,
      this.purposeDetails});
}
