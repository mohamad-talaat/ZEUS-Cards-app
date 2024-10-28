import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zeus/core/constant/app_styles.dart';
import 'package:zeus/core/constant/color.dart';

class CustomButtonAuth extends StatelessWidget {
  final String text;
  final Color? color;
  final void Function()? onPressed;
  const CustomButtonAuth(
      {super.key, required this.text, this.onPressed, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150.w,
      margin: const EdgeInsets.only(top: 10),
      child: MaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.symmetric(vertical: 13),
        onPressed: onPressed,
        color: color ?? AppColor.black,
        textColor: Colors.white,
        child: Text(
          text,
          style: AppTextStyle.montserratSimiBold14WhiteForTransactionsButton,
        ),
      ),
    );
  }
}

class CustomButtonAuthBlueColor extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  const CustomButtonAuthBlueColor(
      {super.key, required this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150.w,
      margin: const EdgeInsets.only(top: 10),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 100.w),
        child: MaterialButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          padding: const EdgeInsets.symmetric(vertical: 8),
          onPressed: onPressed,
          color: AppColor.primaryColor,
          textColor: Colors.white,
          child: Text(
            text,
            style: AppTextStyle.aBeeZeefont20boldblack.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColor.white,
                fontSize: 18),
          ),
        ),
      ),
    );
  }
}
