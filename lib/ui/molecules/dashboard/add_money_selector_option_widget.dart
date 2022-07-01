import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neo_bank/ui/molecules/app_svg.dart';

class AddMoneySelectorOptionsWidget extends StatelessWidget {
  final String? title;
  final String? image;
  final String? desc;
  final String? buttonText;
  final Function()? onTap;
  final bool? isVisible;

  const AddMoneySelectorOptionsWidget(
      {Key? key,
      this.onTap,
      this.title: "",
      this.image,
      this.buttonText: "",
      this.desc: "",
      this.isVisible: true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppSvg.asset(image!, matchTextDirection: true, color: Theme.of(context).accentColor),
        SizedBox(
          width: 12,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title!,
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
                style: TextStyle(
                    fontSize: 14, fontWeight: FontWeight.w600, color: Theme.of(context).accentColor),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                desc!,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.start,
                maxLines: 3,
                style: TextStyle(
                    fontSize: 12, fontWeight: FontWeight.w500, color: Theme.of(context).accentColor),
              ),
              SizedBox(
                height: 16,
              ),
              Visibility(
                visible: isVisible!,
                child: InkWell(
                  onTap: () {
                    onTap?.call();
                  },
                  child: Container(
                    height: 48,
                    decoration: BoxDecoration(
                        color: Theme.of(context).accentTextTheme.bodyText1!.color,
                        borderRadius: BorderRadius.circular(100)),
                    child: Center(
                      child: Text(
                        buttonText!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600, color: Theme.of(context).accentColor),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
