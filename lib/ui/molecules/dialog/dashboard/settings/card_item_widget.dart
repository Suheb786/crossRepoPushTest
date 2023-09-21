import 'package:flutter/material.dart';
import 'package:neo_bank/ui/molecules/dialog/dashboard/settings/settings_dialog_view.dart';
import 'package:neo_bank/ui/molecules/dialog/dashboard/settings/settings_dialog_view_model.dart';

import '../../../stream_builder/app_stream_builder.dart';

class CardItemWidget extends StatefulWidget {
  SettingsDialogViewModel model;
  PagesWidget pageWidget;
  int tappedIndex;

  CardItemWidget(this.model, this.pageWidget, this.tappedIndex, {key}) : super(key: key);

  @override
  State<CardItemWidget> createState() => _CardItemWidgetState();
}

class _CardItemWidgetState extends State<CardItemWidget> with SingleTickerProviderStateMixin {
  late SettingsDialogViewModel model;
  late AnimationController animationController;

  @override
  void initState() {
    model = widget.model;
    animationController = AnimationController(
      duration: const Duration(milliseconds: 250),
      reverseDuration: const Duration(milliseconds: 100),
      vsync: this,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppStreamBuilder<bool>(
        stream: model.onClickStream,
        initialData: false,
        dataBuilder: (context, onClick) {
          return GestureDetector(
            onTap: (onClick ?? false)
                ? () async {
                    model.menuTapped(widget.tappedIndex);
                    animationController.forward();
                    await Future.delayed(const Duration(milliseconds: 100), () {
                      model.menuTapped(-1);
                      animationController.reverse();
                      widget.pageWidget.onTap?.call();
                    });
                  }
                : null,
            child: ScaleTransition(
              key: widget.key,
              scale: Tween<double>(begin: 1.0, end: animationController.value == 1 ? 1 : 0.90)
                  .animate(animationController),
              child: widget.pageWidget.child,
            ),
          );
        });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}
