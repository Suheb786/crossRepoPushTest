import 'package:domain/constants/enum/card_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/base/base_page.dart';
import 'package:neo_bank/di/dashboard/dashboard_modules.dart';
import 'package:neo_bank/feature/dashboard_home/debit_card_timeline/debit_card_timeline_page_view.dart';
import 'package:neo_bank/feature/dashboard_home/debit_card_timeline/debit_card_timeline_view_model.dart';

class DebitCardTimeLinePage extends BasePage<DebitCardTimeLineViewModel> {
  final TimeLinePageArguments _timeLineArguments;

  DebitCardTimeLinePage(this._timeLineArguments);

  @override
  DebitCardTimeLinePageState createState() => DebitCardTimeLinePageState();
}

class DebitCardTimeLinePageState extends BaseStatefulPage<DebitCardTimeLineViewModel, DebitCardTimeLinePage> {
  @override
  ProviderBase provideBase() {
    return debitCardTimeLineViewModelProvider.call(widget._timeLineArguments);
  }

  @override
  Color? scaffoldBackgroundColor() {
    return Theme.of(context).accentColor;
  }

  @override
  Widget buildView(BuildContext context, DebitCardTimeLineViewModel model) {
    return DebitCardTimeLinePageView(provideBase());
  }
}

class TimeLinePageArguments {
  final TimeLineArguments timeLineArguments;
  final CardType cardType;

  TimeLinePageArguments({required this.timeLineArguments, this.cardType: CardType.ACCOUNT});
}
