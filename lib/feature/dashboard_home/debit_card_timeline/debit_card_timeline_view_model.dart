import 'package:domain/usecase/dashboard/debit_card_timeline_usecase.dart';
import 'package:neo_bank/base/base_page_view_model.dart';

class DebitCardTimeLineViewModel extends BasePageViewModel {
  DebitCardTimeLineUseCase _useCase;

  DebitCardTimeLineViewModel(this._useCase);
  int currentStep =1;

  TimeLineArguments timeLineArguments = TimeLineArguments(
      youJoinedBlink: DateTime.now().subtract(Duration(days: 5)),
      blinkWasBorn: DateTime.now().subtract(Duration(days: 20)),
      timelineListArguments: [
        TimeLineListArguments(
          cardCardActivated: DateTime.now().subtract(Duration(days: 5)),
          cardDeliveredDatetime: DateTime.now().subtract(Duration(days: 4)),
        ),
        TimeLineListArguments(
          cardCardActivated: DateTime.now().subtract(Duration(days: 3)),
          cardDeliveredDatetime: DateTime.now().subtract(Duration(days: 2)),
        ),
        TimeLineListArguments(
          cardCardActivated: DateTime.now().subtract(Duration(days: 2)),
          cardDeliveredDatetime: DateTime.now().subtract(Duration(days: 1)),
        )
      ]);

  TimeLineArguments timeLineArguments1 = TimeLineArguments(
      youJoinedBlink: DateTime.now().subtract(Duration(days: 5)),
      blinkWasBorn: DateTime.now().subtract(Duration(days: 20)),
      timelineListArguments: [
        TimeLineListArguments(
          cardCardActivated: DateTime.now().subtract(Duration(days: 5)),
          //cardDeliveredDatetime: DateTime.now().subtract(Duration(days: 4)),
        ),
        TimeLineListArguments(
          //cardCardActivated: DateTime.now().subtract(Duration(days: 5)),
          cardDeliveredDatetime: DateTime.now().subtract(Duration(days: 4)),
        ),
        TimeLineListArguments(
          cardCardActivated: DateTime.now().subtract(Duration(days: 3)),
          //cardDeliveredDatetime: DateTime.now().subtract(Duration(days: 2)),
        ),
        TimeLineListArguments(
          //cardCardActivated: DateTime.now().subtract(Duration(days: 3)),
          cardDeliveredDatetime: DateTime.now().subtract(Duration(days: 2)),
        ),
        TimeLineListArguments(
          cardCardActivated: DateTime.now().subtract(Duration(days: 2)),
          //cardDeliveredDatetime: DateTime.now().subtract(Duration(days: 1)),
        ),TimeLineListArguments(
          //cardCardActivated: DateTime.now().subtract(Duration(days: 2)),
          cardDeliveredDatetime: DateTime.now().subtract(Duration(days: 1)),
        )
      ]);
}

class TimeLineListArguments {
  final DateTime? cardDeliveredDatetime;
  final DateTime? cardCardActivated;

  TimeLineListArguments({this.cardDeliveredDatetime, this.cardCardActivated});
}

class TimeLineArguments {
  final DateTime? youJoinedBlink;
  final DateTime? blinkWasBorn;
  final List<TimeLineListArguments>? timelineListArguments;

  TimeLineArguments(
      {this.youJoinedBlink, this.blinkWasBorn, this.timelineListArguments});
}
