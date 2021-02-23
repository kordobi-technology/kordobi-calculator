import 'package:flutter/material.dart';

class SpecialButton extends StatelessWidget {
  final color;
  final textColor;
  final String buttonText;
  final buttonTapped;
// """"""""""""انشاء خواص لهذا الزر

  SpecialButton(
      {this.color, this.textColor, this.buttonText, this.buttonTapped});
  // """""""""""" تجهيز الخواص

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: buttonTapped,
      child: Container(
        color: color,
        child: Center(
          child: Text(
            buttonText,
            style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.w400,
                fontSize: 15,
                fontFamily: "NanumGothic"),
          ),
        ),
      ),
    );
  }
}
