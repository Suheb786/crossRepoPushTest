import 'package:domain/model/bill_payments/pay_post_paid_bill/biller_list.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/utils/string_utils.dart';

class ShareInfo {
  ShareInfo._();

  static String newPostPaidSuccess(
    BuildContext context, {
    required String billerName,
    required String nickName,
    required String? amount,
    required String refNo,
  }) {
    final newLine = "\n\n";
    final newLineX2 = "\n\n\n";

    final title = S.of(context).billDetails + ":" + newLineX2;

    final billNameText = S.of(context).billName + ": " + billerName + newLine;

    final nickText = nickName.isNotEmpty ? S.of(context).nickName + ": " + nickName + newLine : "";

    final amountText = S.of(context).amount + ": " + double.parse(amount ?? "0").toStringAsFixed(3) + newLine;

    final refNoText = S.of(context).refNo + ": " + refNo + newLine;

    return title + billNameText + nickText + amountText + refNoText;
  }

  static String savedMultipleBillsPostPaidSuccess(
    BuildContext context, {
    required List<BillerList>? paidBillsList,
  }) {
    var allBillsString = "";
    final newLine = "\n\n";
    final newLineX2 = "\n\n\n";

    if (paidBillsList != null && paidBillsList.isNotEmpty) {
      for (var item in paidBillsList) {
        var billNameText = "";
        var amountText = "";
        var refNoText = "";

        if (item != null) {
          if (getBillerName(context, item) != null && getBillerName(context, item).isNotEmpty) {
            billNameText = S.of(context).billName + ": " + getBillerName(context, item) + newLine;
          } else {
            billNameText = "";
          }

          if (item.totalAmount != null && item.totalAmount!.isNotEmpty) {
            amountText = S.of(context).amount +
                ": " +
                double.parse(item.totalAmount ?? "0").toStringAsFixed(3) +
                newLine;
          } else {
            amountText = "";
          }
          if (item.refNo != null && item.refNo!.isNotEmpty) {
            refNoText = S.of(context).refNo + ": " + item.refNo! + newLine;
          } else {
            refNoText = "";
          }
          if (item.isPaid == true) {
            allBillsString = allBillsString + newLine + billNameText + amountText + refNoText;
          }
        }
      }
    }

    final title = S.of(context).billDetails + ":" + newLineX2;

    return title + allBillsString;
  }
}

String getBillerName(BuildContext context, BillerList item) {
  return StringUtils.isDirectionRTL(context) ? item.billerNameAR ?? "" : item.billerName ?? "";
}
