import 'package:flutter/material.dart';

import '../../../../core/constants/color_constants.dart';

class CurvedBox extends StatelessWidget {
  const CurvedBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: ColorConstants.primaryColor,
      child: Container(
        height: 24,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            color: ColorConstants.bgColor),
      ),
    );
  }
}
