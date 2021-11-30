import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neo_bank/di/dashboard/dashboard_modules.dart';

class CreditCardDetailDialogView extends StatelessWidget {
  const CreditCardDetailDialogView();

  ProviderBase providerBase() {
    return creditCardDetailDialogViewModelProvider;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 47, right: 48),
      child: Center(
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          elevation: 2,
          color: Theme.of(context).primaryColor,
          margin: EdgeInsets.zero,
          shadowColor: Theme.of(context).primaryColorDark.withOpacity(0.32),
          child: Padding(
            padding: EdgeInsets.only(left: 29.0, top: 38, right: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Zein Malhas",
                      style: TextStyle(
                          color: Theme.of(context).accentColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Flip back",
                        style: TextStyle(
                            color:
                                Theme.of(context).accentColor.withOpacity(0.6),
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 63),
                  child: Text(
                    "8451 1353 1245 3421",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).accentColor,
                      fontSize: 16,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: Text(
                    "CARD NUMBER",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).accentColor.withOpacity(0.6),
                        fontSize: 10),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 19),
                  child: Divider(
                    height: 1,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 21),
                  child: Text(
                    "140591314151414",
                    style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: Text("LINKED ACCOUNT NUMBER",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 10,
                        color: Theme.of(context).accentColor.withOpacity(0.6),
                      )),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 19),
                  child: Divider(
                    height: 1,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 21, bottom: 128),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "08/23",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: Theme.of(context).accentColor,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 8),
                            child: Text(
                              "EXPIRY DATE",
                              style: TextStyle(
                                  fontSize: 10,
                                  color: Theme.of(context)
                                      .accentColor
                                      .withOpacity(0.6),
                                  fontWeight: FontWeight.w600),
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 59.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "688",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).accentColor,
                                fontSize: 16,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 8),
                              child: Text(
                                "CVV",
                                style: TextStyle(
                                    fontSize: 10,
                                    color: Theme.of(context)
                                        .accentColor
                                        .withOpacity(0.6),
                                    fontWeight: FontWeight.w600),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
