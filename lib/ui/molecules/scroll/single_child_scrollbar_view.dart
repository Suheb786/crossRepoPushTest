import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SingleChildScrollBarView extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;

  const SingleChildScrollBarView({Key? key, required this.child, this.padding: EdgeInsets.zero})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
        child: SingleChildScrollView(
      physics: ClampingScrollPhysics(),
      padding: padding,
      child: child,
    ));
  }
}
