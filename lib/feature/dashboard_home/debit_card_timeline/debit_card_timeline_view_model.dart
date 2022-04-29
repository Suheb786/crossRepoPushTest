import 'package:domain/constants/enum/card_type.dart';
import 'package:domain/model/dashboard/get_placeholder/placeholder_data.dart';
import 'package:domain/usecase/dashboard/debit_card_timeline_usecase.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/feature/dashboard_home/debit_card_timeline/debit_card_timeline_page.dart';

class DebitCardTimeLineViewModel extends BasePageViewModel {
  DebitCardTimeLineUseCase _useCase;

  TimeLinePageArguments timeLineArguments;

  DebitCardTimeLineViewModel(this._useCase, this.timeLineArguments);

  int currentStep = 1;

// TimeLineArguments timeLineArguments = TimeLineArguments(
//     youJoinedBlink: DateTime.now().subtract(Duration(days: 5)).toString(),
//     blinkWasBorn: DateTime.now().subtract(Duration(days: 20)).toString(),
//     timelineListArguments: [
//       TimeLineListArguments(
//         cardCardActivated:
//             DateTime.now().subtract(Duration(days: 5)).toString(),
//         cardDeliveredDatetime:
//             DateTime.now().subtract(Duration(days: 4)).toString(),
//       ),
//       TimeLineListArguments(
//         cardCardActivated:
//             DateTime.now().subtract(Duration(days: 3)).toString(),
//         cardDeliveredDatetime:
//             DateTime.now().subtract(Duration(days: 2)).toString(),
//       ),
//       TimeLineListArguments(
//         cardCardActivated:
//             DateTime.now().subtract(Duration(days: 2)).toString(),
//         cardDeliveredDatetime:
//             DateTime.now().subtract(Duration(days: 1)).toString(),
//       )
//     ]);
}

class TimeLineListArguments {
  String? cardDeliveredDatetime;
  String? cardCardActivated;
  String? cardNumber;
  String? accountTitle;
  String? cardId;
  CardType cardType;
  bool? isCardDelivered;

  TimeLineListArguments(
      {this.cardDeliveredDatetime: "",
      this.cardCardActivated: "",
      this.cardId: "",
      this.cardNumber: "",
      this.accountTitle: "",
      this.cardType: CardType.DEBIT,
      this.isCardDelivered: false});
}

class TimeLineArguments {
  String? youJoinedBlink;
  String? blinkWasBorn;
  String? availableBalance;

  List<TimeLineListArguments> timelineListArguments;
  PlaceholderData? placeholderData;

  TimeLineArguments(
      {this.youJoinedBlink: "",
      this.blinkWasBorn: "",
      required this.timelineListArguments,
      this.availableBalance: '0.000',
      this.placeholderData});
}
