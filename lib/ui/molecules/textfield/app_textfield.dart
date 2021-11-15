import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:neo_bank/utils/color_utils.dart';

class AppTextField extends StatefulWidget {
  final double? height;
  final double? width;
  final Widget? child;
  final Function()? onPressed;
  final TextEditingController? controller;
  final TextInputAction? inputAction;
  final TextInputType? inputType;
  final String labelText;
  final String hintText;
  final String? initialValue;
  final bool? autoFocus;
  final FormFieldValidator<String>? validator;
  final Function(String)? onChanged;
  final FormFieldSetter<String>? onSaved;
  final Function(String)? onFieldSubmitted;
  final bool? readOnly;
  final int? maxLength;
  final bool? obscureText;
  final String obscuringCharacter;
  final Widget Function(bool enabled, String value)? suffixIcon;
  final Widget Function()? prefixIcon;
  final Key? key;
  final Widget Function()? prefix;
  final bool enabled;
  final int maxLines;
  final int minLines;
  final TextAlign textAlign;
  final List<TextInputFormatter>? inputFormatters;
  final bool busy;
  final FloatingLabelBehavior floatingLabelBehavior;
  final bool filled;
  final Color filledColor;
  final double fontSize;
  final double labelFontSize;
  final Function(bool hasFocus, bool isValid, String value)? textHintWidget;
  final EdgeInsets dividerPadding;
  final Function? labelIcon;
  final Color? textFieldFocusBorderColor;
  final Color? textFieldBorderColor;
  final Color? hintTextColor;
  final Color? textColor;
  final Color? labelColor;
  final double suffixIconSize;

  AppTextField(
      {this.height,
      this.width,
      this.child,
      this.onPressed,
      this.controller,
      this.inputAction: TextInputAction.done,
      this.inputType,
      required this.labelText,
      required this.hintText,
      this.initialValue,
      this.autoFocus: false,
      this.validator,
      this.onSaved,
      this.readOnly: false,
      this.maxLength,
      this.key,
      this.obscureText: false,
      this.obscuringCharacter: '•',
      this.suffixIcon,
      this.prefixIcon,
      this.prefix,
      this.enabled: true,
      this.inputFormatters,
      this.busy: false,
      this.maxLines: 1,
      this.minLines: 1,
      this.onChanged,
      this.filled: false,
      this.fontSize: 14,
      this.labelFontSize: 14,
      this.filledColor: AppColor.white,
      this.onFieldSubmitted,
      this.labelIcon,
      this.dividerPadding:
          const EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 0),
      this.floatingLabelBehavior: FloatingLabelBehavior.never,
      this.textAlign: TextAlign.start,
      this.textFieldBorderColor,
      this.textFieldFocusBorderColor,
      this.hintTextColor,
      this.textColor,
      this.labelColor,
      this.textHintWidget,
      this.suffixIconSize: 30})
      : super(key: key);

  @override
  AppTextFieldState createState() => AppTextFieldState();
}

class AppTextFieldState extends State<AppTextField> {
  late bool _secureText;
  FocusNode _focusNode = FocusNode();
  bool _isValid = true;

  @override
  void initState() {
    super.initState();
    _secureText = widget.obscureText!;
    _focusNode.addListener(_onFocusChange);
  }

  bool get secureText => _secureText;

  set secureText(bool value) {
    setState(() {
      _secureText = value;
    });
  }

  bool get isValid => _isValid;

  set isValid(bool value) {
    setState(() {
      _isValid = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: this.widget.width,
        height: this.widget.height,
        child: Padding(
          padding: EdgeInsets.all(0.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                        width: 1,
                        color: !isValid
                            ? Theme.of(context)
                                .inputDecorationTheme
                                .errorBorder!
                                .borderSide
                                .color
                            : _focusNode.hasFocus
                                ? (widget.textFieldFocusBorderColor ??
                                    Theme.of(context)
                                        .inputDecorationTheme
                                        .focusedBorder!
                                        .borderSide
                                        .color)
                                : (widget.textFieldBorderColor ??
                                    Theme.of(context)
                                        .inputDecorationTheme
                                        .enabledBorder!
                                        .borderSide
                                        .color))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(children: [
                        TextSpan(
                            text: widget.labelText,
                            style: DefaultTextStyle.of(context).style.copyWith(
                                  color: widget.labelColor ??
                                      Theme.of(context)
                                          .inputDecorationTheme
                                          .labelStyle!
                                          .color,
                                  fontSize: 10,
                                  fontFamily: "Montserrat",
                                )),
                        WidgetSpan(
                            child: widget.labelIcon?.call() ?? Container())
                      ]),
                    ),
                    TextFormField(
                      focusNode: _focusNode,
                      maxLength: widget.maxLength,
                      textAlign: widget.textAlign,
                      style: TextStyle(
                        // color: widget.textColor ?? AppColor.very_light_gray,
                        fontSize: widget.fontSize,
                        fontWeight: FontWeight.w600,
                      ),
                      initialValue: widget.initialValue,
                      autofocus: widget.autoFocus!,
                      textInputAction: widget.inputAction,
                      keyboardType: widget.inputType,
                      inputFormatters: widget.inputFormatters,
                      readOnly: widget.readOnly ?? false,
                      maxLines: widget.maxLines,
                      minLines: widget.minLines,
                      obscureText: secureText,
                      cursorColor: widget.hintTextColor ??
                          Theme.of(context).textSelectionTheme.cursorColor,
                      obscuringCharacter: widget.obscuringCharacter,
                      decoration: InputDecoration(
                          prefix: widget.prefix?.call(),
                          prefixIcon: widget.prefixIcon?.call(),
                          prefixIconConstraints:
                              BoxConstraints.tightForFinite(),
                          contentPadding: EdgeInsets.only(top: 8),
                          hintText: widget.hintText,
                          hintMaxLines: 1,
                          counterText: "",
                          alignLabelWithHint: true,
                          isDense: true,
                          filled: widget.filled,
                          fillColor: widget.filledColor,
                          hintStyle: TextStyle(
                            color: widget.hintTextColor ??
                                Theme.of(context)
                                    .inputDecorationTheme
                                    .hintStyle!
                                    .color,
                            fontSize: widget.fontSize,
                            fontWeight: FontWeight.w600,
                          ),
                          suffixIcon: widget.suffixIcon
                              ?.call(isValid, widget.controller!.text),
                          suffixIconConstraints: BoxConstraints.tight(Size(
                              widget.suffixIconSize, widget.suffixIconSize)),
                          enabled: widget.enabled,
                          floatingLabelBehavior: widget.floatingLabelBehavior),
                      controller: widget.controller,
                      validator: this.widget.validator,
                      onSaved: this.widget.onSaved,
                      onTap: this.widget.onPressed,
                      onFieldSubmitted: this.widget.onFieldSubmitted,
                      onChanged: (value) {
                        setState(() {});
                        widget.onChanged?.call(value);
                      },
                    ),
                  ],
                ),
              ),
              widget.textHintWidget?.call(
                      _focusNode.hasFocus, isValid, widget.controller!.text) ??
                  Container(),
            ],
          ),
        ));
  }

  void _onFocusChange() {
    setState(() {
      isValid = true;
    });
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }
}
