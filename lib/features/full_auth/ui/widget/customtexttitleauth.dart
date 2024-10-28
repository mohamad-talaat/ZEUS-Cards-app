import 'package:flutter/material.dart';
import 'package:zeus/core/constant/app_styles.dart';

class CustomTextTitleAuth extends StatelessWidget {
  final String text;
  const CustomTextTitleAuth({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(text,
        textAlign: TextAlign.center,
        style: AppTextStyle
            .aBeeZeefont20boldblack // Theme.of(context).textTheme.displayMedium,
        );
  }
}
