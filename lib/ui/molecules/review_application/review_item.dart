import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/generated/l10n.dart';
import 'package:neo_bank/utils/color_utils.dart';

// class ReviewApplicationEditableItem extends StatelessWidget {
//   final String title;
//   final TextEditingController? controller;
//   final String? initialValue;
//   final Widget? prefixWidget;
//   final TextInputType? textInputType;
//
//   const ReviewApplicationEditableItem(
//       {Key? key,
//       required this.title,
//       this.initialValue,
//       this.textInputType,
//       this.prefixWidget,
//       this.controller})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.only(top: 8, bottom: 8),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: <Widget>[
//           Flexible(
//             child: Text(
//               title,
//               softWrap: true,
//               style: TextStyle(
//                   fontSize: 12,
//                   fontWeight: FontWeight.w400,
//                   color: AppColor.very_dark_gray),
//             ),
//           ),
//           Flexible(
//             child: TextFormField(
//               controller: controller,
//               initialValue: initialValue,
//               maxLines: 2,
//               ///For now fields should not be editable
//               readOnly: true,
//               textAlign: TextAlign.end,
//               keyboardType: textInputType,
//               cursorColor: Theme.of(context).primaryColorDark,
//               style: TextStyle(
//                   fontSize: 12,
//                   fontWeight: FontWeight.w600,
//                   color: Theme.of(context).primaryColorDark),
//               decoration: InputDecoration(
//                   border: InputBorder.none,
//                   isCollapsed: true,
//                   hintText: S.of(context).pleaseEnter,
//                   prefixIconConstraints: BoxConstraints.tightForFinite(),
//                   prefixIcon: this.prefixWidget),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
class ReviewApplicationEditableItem extends StatelessWidget {
  final String title;
  final TextEditingController? controller;
  final String? initialValue;
  final Widget? prefixWidget;
  final TextInputType? textInputType;
  final bool isPrefix;

  const ReviewApplicationEditableItem(
      {Key? key,
      required this.title,
      this.initialValue,
      this.textInputType,
      this.prefixWidget,
      this.controller,
      this.isPrefix: false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8, bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            child: Text(
              title,
              softWrap: true,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: AppColor.very_dark_gray),
            ),
          ),
          Flexible(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                isPrefix
                    ? Text(
                        S.of(context).JOD,
                        textAlign: TextAlign.end,
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).primaryColorDark),
                      )
                    : Container(),
                SizedBox(
                  width: 5,
                ),
                // Flexible(
                //   child: TextFormField(
                //     controller: controller,
                //     initialValue: initialValue,
                //     maxLines: 2,
                //
                //     ///For now fields should not be editable
                //     readOnly: true,
                //     textAlign: TextAlign.end,
                //     keyboardType: textInputType,
                //     cursorColor: Theme.of(context).primaryColorDark,
                //     style: TextStyle(
                //         fontSize: 12,
                //         fontWeight: FontWeight.w600,
                //         color: Theme.of(context).primaryColorDark),
                //     decoration: InputDecoration(
                //       contentPadding: EdgeInsets.zero,
                //       border: InputBorder.none,
                //       isCollapsed: true,
                //       hintText: S.of(context).pleaseEnter,
                //       // prefixIconConstraints: BoxConstraints.tightForFinite(),
                //       // prefixIcon: this.prefixWidget
                //     ),
                //   ),
                // ),
                Flexible(
                  child: Text(
                    initialValue!,
                    textAlign: TextAlign.end,
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).primaryColorDark),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
