import 'package:flutter/material.dart';

import '../../../../core/constants/color_constants.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final double borderRadius;
  const CustomButton({Key? key, required this.text, required this.onTap, this.borderRadius = 4})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox.expand(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
            gradient: const LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [
                ColorConstants.primaryColorVariant,
                ColorConstants.primaryColor,
              ],
            ),
          ),
          child: Center(
            child: Text(
              text,
              style:
                  const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ),
    );
  }
}
