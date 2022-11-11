import 'package:flutter/cupertino.dart';
import 'package:neo_bank/base/base_page_view_model.dart';

class SelectedCardForApplePayPageViewModel extends BasePageViewModel {
  SelectedCardForApplePayPageViewModel() {}
  ScrollController scrollController = ScrollController();
  List<CardTypeData> list = [];

  @override
  void dispose() {
    super.dispose();
  }
}

class CardTypeData {
  final String? cardType;
  final String? cardImage;
  final String? cardTypeInformation;

  CardTypeData(this.cardType, this.cardImage, this.cardTypeInformation);
}
