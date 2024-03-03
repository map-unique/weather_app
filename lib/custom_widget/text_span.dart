import 'package:flutter/material.dart';

class ColorText extends StatelessWidget {
  ColorText(
      {super.key,
      required this.firstText,
      required this.secondText,
      required this.fontSize,
      this.fontWeight,
      this.firstColor,
      this.secondColor});

  dynamic firstText;
  dynamic secondText;
  double fontSize;
  FontWeight? fontWeight;
  Color? firstColor;
  Color? secondColor;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(children: [
        TextSpan(

          text: firstText,
          style: TextStyle(color: firstColor, fontSize: fontSize),
        ),
        TextSpan(
          text: secondText,
          style: TextStyle(
              color: secondColor, fontSize: fontSize, fontWeight: fontWeight),
        ),
      ]),
    );
  }
}
