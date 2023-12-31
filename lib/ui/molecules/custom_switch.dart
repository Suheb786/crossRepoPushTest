import 'package:flutter/material.dart';
import 'package:neo_bank/utils/color_utils.dart';
import 'package:neo_bank/utils/string_utils.dart';

class CustomSwitch extends StatefulWidget {
  final bool? value;
  final ValueChanged<bool>? onChanged;
  final Color? activeColor;

  const CustomSwitch({Key? key, this.value, this.onChanged, this.activeColor}) : super(key: key);

  @override
  _CustomSwitchState createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> with SingleTickerProviderStateMixin {
  Animation? _circleAnimation;

  AnimationController? _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 60));

    _circleAnimation = AlignmentTween(
            begin: widget.value! ? Alignment.centerRight : Alignment.centerLeft,
            end: widget.value! ? Alignment.centerLeft : Alignment.centerRight)
        .animate(CurvedAnimation(parent: _animationController!, curve: Curves.linear));
  }

  @override
  void dispose() {
    _animationController!.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController!,
      builder: (context, child) {
        return GestureDetector(
          onTap: () {
            if (_animationController!.isCompleted) {
              _animationController!.reverse();
            } else {
              _animationController!.forward();
            }

            setState(() {
              widget.value == false ? widget.onChanged!(true) : widget.onChanged!(false);
            });
          },
          child: Container(
            width: 75.0,
            height: 40.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(
                    color: _circleAnimation!.value == Alignment.centerLeft
                        ? Colors.grey.withOpacity(0.5)
                        : widget.activeColor!),
                color: _circleAnimation!.value == Alignment.centerLeft ? AppColor.white : widget.activeColor),
            child: Padding(
              padding: const EdgeInsetsDirectional.only(top: 4.0, bottom: 4.0, end: 4.0, start: 4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  _circleAnimation!.value == Alignment.centerRight
                      ? Padding(
                          padding: const EdgeInsetsDirectional.only(start: 4.0, end: 4.0),
                          child: Text(
                            'Yes',
                            style: TextStyle(
                                fontFamily: StringUtils.appFont,
                                color: _circleAnimation!.value == Alignment.centerLeft
                                    ? Colors.grey
                                    : Colors.white70,

                                // fontWeight: FontWeight.w900,

                                fontSize: 14.0),
                          ),
                        )
                      : Container(),
                  Align(
                    alignment: _circleAnimation!.value,
                    child: Container(
                      width: 25.0,
                      height: 25.0,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _circleAnimation!.value == Alignment.centerLeft
                              ? Colors.grey.withOpacity(0.2)
                              : AppColor.white),
                    ),
                  ),
                  _circleAnimation!.value == Alignment.centerLeft
                      ? Padding(
                          padding: const EdgeInsetsDirectional.only(start: 4.0, end: 5.0),
                          child: Text(
                            'No',
                            style: TextStyle(
                                fontFamily: StringUtils.appFont,
                                color: _circleAnimation!.value == Alignment.centerLeft
                                    ? Colors.grey
                                    : Colors.white70,
                                fontWeight: FontWeight.normal,
                                fontSize: 14.0),
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
