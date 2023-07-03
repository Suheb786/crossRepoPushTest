import 'package:domain/constants/enum/request_money_activity_enum.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/base/base_page_view_model.dart';
import 'package:neo_bank/utils/color_utils.dart';

class PaymentActivityViewModel extends BasePageViewModel {
  Color getColor(RequestMoneyActivityStatusEnum? value) {
    switch (value) {
      case RequestMoneyActivityStatusEnum.CATEGORY_ACCEPTED:
        return AppColor.darkModerateLimeGreen;
      case RequestMoneyActivityStatusEnum.CATEGORY_REJECTED:
        return AppColor.dark_brown;
      case RequestMoneyActivityStatusEnum.CATEGORY_PENDING:
        return AppColor.dark_orange;

      default:
        return AppColor.darkModerateLimeGreen;
    }
  }
}
