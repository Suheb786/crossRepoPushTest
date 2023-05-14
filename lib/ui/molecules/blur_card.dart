import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:neo_bank/utils/asset_utils.dart';
import 'package:neo_bank/utils/color_utils.dart';

class BlurCard extends StatelessWidget {
  const BlurCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
      height: 260,
      child: Center(
        child: Transform.rotate(
          angle: 46.52 * (math.pi / 180),
          child: Container(
            constraints: BoxConstraints(maxHeight: 142.53, maxWidth: 227.51),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8), border: Border.all(color: AppColor.white)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              clipBehavior: Clip.antiAlias,
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaY: 4, sigmaX: 4),
                child: Container(
                  decoration: BoxDecoration(color: AppColor.white.withOpacity(0.2)),
                  padding: EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 20,
                        height: 20,
                        child: Image.asset(
                          AssetUtils.contactLess,
                        ),
                      ),
                      Center(
                          child: Container(
                        width: 51,
                        height: 51,
                        child: Image.asset(
                          AssetUtils.cardLogo,
                        ),
                      )),
                      Container(
                        width: 40.1,
                        height: 12.86,
                        child: Image.asset(
                          AssetUtils.visa,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
