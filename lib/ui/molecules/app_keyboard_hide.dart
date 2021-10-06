import 'package:flutter/cupertino.dart';

class AppKeyBoardHide extends StatelessWidget {
  final Widget child;

  const AppKeyBoardHide({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: child,
    );
  }
}
