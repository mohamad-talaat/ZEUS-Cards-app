import 'package:flutter/material.dart';
import 'package:zeus/core/constant/app_styles.dart';
import 'package:zeus/core/constant/color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget buttonsNameAndPressed(
    {required String buttonTitle,
    TextStyle? style,
    Color? buttonColor,
    required void Function() onPressed}) {
  return MaterialButton(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0), // Adjust the radius as needed
    ),
    color: buttonColor ?? AppColor.primaryColor,
    onPressed: onPressed,
    child: Text(
      buttonTitle,
      style: style ??
          AppTextStyle.montserratSimiBold14White.copyWith(fontSize: 11),

      // .copyWith(fontWeight: FontWeight.bold),
    ),
  );
}

Widget submitButton({required Widget child, required onPressed}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 109),
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColor.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6.0),
        ),
        padding: const EdgeInsets.symmetric(
            horizontal: 7.0, vertical: 10.0), // Adjust padding as needed
      ),
      child: child,
    ),
  );
}

Widget buttonForImageUpload(
    {required String buttonTitle, required void Function() onPressed}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 25.w),
    child: MaterialButton(
      padding: const EdgeInsets.symmetric(
          horizontal: 16.0, vertical: 12.0), // Adjust padding as needed
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      color: AppColor.primaryColor,
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.attachment_rounded,
            color: AppColor.white,
          ),
          SizedBox(
            width: 8.w,
          ),
          Text(
            buttonTitle,
            style: AppTextStyle.montserratSimiBold14White,
          ),
        ],
      ),
    ),
  );
}
