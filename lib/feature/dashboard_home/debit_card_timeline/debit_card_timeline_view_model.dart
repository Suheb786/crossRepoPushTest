import 'package:domain/constants/enum/card_type.dart';
import 'package:domain/model/dashboard/get_placeholder/placeholder_data.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/feature/dashboard_home/debit_card_timeline/debit_card_timeline_page.dart';

class DebitCardTimeLineViewModel extends BasePageViewModel {
  TimeLinePageArguments timeLineArguments;

  DebitCardTimeLineViewModel(this.timeLineArguments);

  int currentStep = 1;
}

class TimeLineListArguments {
  String? cardDeliveredDatetime;
  String? cardCardActivated;
  String? cardNumber;
  String? accountTitle;
  String? cardId;
  CardType cardType;
  bool? isCardDelivered;
  bool? isIssuedFromCMS;
  String? secureCode;

  TimeLineListArguments(
      {this.cardDeliveredDatetime = "",
      this.cardCardActivated = "",
      this.cardId = "",
      this.cardNumber = "",
      this.accountTitle = "",
      this.cardType = CardType.DEBIT,
      this.isCardDelivered = false,
      this.secureCode = '',
      this.isIssuedFromCMS = false});
}

class TimeLineArguments {
  String? youJoinedBlink;
  String? blinkWasBorn;
  String? availableBalance;

  List<TimeLineListArguments> timelineListArguments;
  PlaceholderData? placeholderData;

  TimeLineArguments(
      {this.youJoinedBlink = "",
      this.blinkWasBorn = "",
      required this.timelineListArguments,
      this.availableBalance = '0.000',
      this.placeholderData});
}
