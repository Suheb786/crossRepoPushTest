import 'package:flutter/material.dart';
import 'package:neo_bank/utils/sizer_helper_util.dart';
import 'package:neo_bank/utils/string_utils.dart';

typedef KeyboardTapCallback = void Function(String text);

class NumericKeyboard extends StatefulWidget {
  /// Color of the text [default = Colors.black]
  final Color textColor;

  /// Display a custom right icon
  final Widget? rightWidget;

  /// Action to trigger when right button is pressed
  final Function()? rightButtonFn;

  /// Display a custom left icon
  final Icon? leftIcon;

  /// Action to trigger when left button is pressed
  final Function()? leftButtonFn;

  /// Callback when an item is pressed
  final KeyboardTapCallback onKeyboardTap;

  /// Main axis alignment [default = MainAxisAlignment.spaceEvenly]
  final MainAxisAlignment mainAxisAlignment;

  NumericKeyboard(
      {Key? key,
      required this.onKeyboardTap,
      this.textColor = Colors.black,
      this.rightButtonFn,
      this.rightWidget,
      this.leftButtonFn,
      this.leftIcon,
      this.mainAxisAlignment = MainAxisAlignment.spaceEvenly})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _NumericKeyboardState();
  }
}

class _NumericKeyboardState extends State<NumericKeyboard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: const EdgeInsets.only(left: 32, right: 32, top: 20),
      alignment: Alignment.center,
      child: Column(
        children: <Widget>[
          ButtonBar(
            alignment: widget.mainAxisAlignment,
            children: <Widget>[
              _calcButton('1'),
              _calcButton('2'),
              _calcButton('3'),
            ],
          ),
          ButtonBar(
            alignment: widget.mainAxisAlignment,
            children: <Widget>[
              _calcButton('4'),
              _calcButton('5'),
              _calcButton('6'),
            ],
          ),
          ButtonBar(
            alignment: widget.mainAxisAlignment,
            children: <Widget>[
              _calcButton('7'),
              _calcButton('8'),
              _calcButton('9'),
            ],
          ),
          Directionality(
            textDirection:
            StringUtils.isDirectionRTL(context) ? TextDirection.rtl : TextDirection.ltr,
            child: ButtonBar(
              alignment: widget.mainAxisAlignment,
              children: <Widget>[
                InkWell(
                    borderRadius: BorderRadius.circular(45),
                    onTap: widget.leftButtonFn,
                    child: Container(
                        alignment: Alignment.center, width: 50.0.w, height: 50.0.h, child: widget.leftIcon)),
                _calcButton('0'),
                InkWell(
                    borderRadius: BorderRadius.circular(45),
                    onTap: widget.rightButtonFn,
                    child: Container(
                        alignment: Alignment.center, width: 50.0.w, height: 50.0.h, child: widget.rightWidget))
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _calcButton(String value) {
    return InkWell(
        borderRadius: BorderRadius.circular(45),
        onTap: () {
          widget.onKeyboardTap(value);
        },
        child: Container(
          alignment: Alignment.center,
          width: 50.0.w,
          height: 50.0.h,
          child: Text(
            value,
            style: TextStyle(
                fontFamily: StringUtils.appFont,
                fontSize: 28.0.t,
                fontWeight: FontWeight.normal,
                color: widget.textColor),
          ),
        ));
  }
}
