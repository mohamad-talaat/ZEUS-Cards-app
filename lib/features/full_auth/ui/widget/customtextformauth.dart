// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:zeus/core/constant/app_styles.dart';
import 'package:zeus/core/constant/color.dart';

// ignore: must_be_immutable

class CustomTextFormAuth extends StatelessWidget {
  final String hinttext;
  bool? ReadOnly;
  final String labeltext;
  final IconData? iconData;
  final TextEditingController? mycontroller;
  final String? Function(String?) valid;
  final bool isNumber;
  final bool? obscureText;
  final void Function()? onTapIcon;
  Function(dynamic value)? onChanged;
  CustomTextFormAuth(
      {super.key,
      this.obscureText,
      this.ReadOnly,
      this.onTapIcon,
      required this.hinttext,
      required this.labeltext,
      this.iconData,
      required this.mycontroller,
      required this.valid,
      required this.isNumber,
      Function(dynamic value)? onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.w),
      margin: const EdgeInsets.only(bottom: 20),
      // width: 200.w,
      child: Column(
        children: [
          TextFormField(
            inputFormatters: isNumber
                ? []
                : [LetterOnlyFormatter()], // Only use formatter for text fields
            readOnly: ReadOnly ?? false,
            keyboardType: isNumber
                ? const TextInputType.numberWithOptions(decimal: true)
                : TextInputType.text,
            style: AppTextStyle.montserratSimiBold14Black.copyWith(
              fontWeight: FontWeight.w300,
              color: Colors.black,
            ),
            validator: valid,
            controller: mycontroller,
            obscureText:
                obscureText == null || obscureText == false ? false : true,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: AppColor.grey)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: AppColor.grey)),

              hintText: toBeginningOfSentenceCase(hinttext),
              hintStyle: AppTextStyle.montserratSimiBold14Black.copyWith(
                fontWeight: FontWeight.w300,
                fontSize: 13.5,
                color: Colors.black54,
              ),
              floatingLabelBehavior: FloatingLabelBehavior.always,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
              label: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 9),
                  child: Text(toBeginningOfSentenceCase(labeltext),
                      style:
                          AppTextStyle.montserratSimiBold14BlackForLabelText)),

              suffixIcon: InkWell(onTap: onTapIcon, child: Icon(iconData)),
              // border:
              //     OutlineInputBorder(borderRadius: BorderRadius.circular(30))
            ),
          ),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class CustomTextFormAuthAcceptNumsAndChar extends StatelessWidget {
  final String hinttext;
  bool? ReadOnly;
  final String labeltext;
  final IconData? iconData;
  final TextEditingController? mycontroller;
  final String? Function(String?) valid;
  final bool isNumber;
  final bool? obscureText;
  final void Function()? onTapIcon;
  Function(dynamic value)? onChanged;
  CustomTextFormAuthAcceptNumsAndChar(
      {super.key,
      this.obscureText,
      this.ReadOnly,
      this.onTapIcon,
      required this.hinttext,
      required this.labeltext,
      this.iconData,
      required this.mycontroller,
      required this.valid,
      required this.isNumber,
      Function(dynamic value)? onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.w),
      margin: const EdgeInsets.only(bottom: 20),
      // width: 200.w,
      child: Column(
        children: [
          TextFormField(
            readOnly: ReadOnly ?? false,
            keyboardType: isNumber
                ? const TextInputType.numberWithOptions(decimal: true)
                : TextInputType.text,
            style: AppTextStyle.montserratSimiBold14Black.copyWith(
              fontWeight: FontWeight.w300,
              color: Colors.black,
            ),
            validator: valid,
            controller: mycontroller,
            obscureText:
                obscureText == null || obscureText == false ? false : true,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: AppColor.grey)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: AppColor.grey)),

              hintText: toBeginningOfSentenceCase(hinttext),
              hintStyle: AppTextStyle.montserratSimiBold14Black.copyWith(
                fontWeight: FontWeight.w300,
                color: Colors.black54,
              ),
              floatingLabelBehavior: FloatingLabelBehavior.always,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
              label: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 9),
                  child: Text(toBeginningOfSentenceCase(labeltext),
                      style:
                          AppTextStyle.montserratSimiBold14BlackForLabelText)),

              suffixIcon: InkWell(onTap: onTapIcon, child: Icon(iconData)),
              // border:
              //     OutlineInputBorder(borderRadius: BorderRadius.circular(30))
            ),
          ),
        ],
      ),
    );
  }
}

class LetterOnlyFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Allow only letters and spaces
    if (newValue.text.isEmpty) return newValue;
    return TextEditingValue(
      text: newValue.text.replaceAll(RegExp(r'[^a-zA-Z ]'), ''),
      selection: TextSelection.collapsed(offset: newValue.text.length),
    );
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String newText = newValue.text;

    // Capitalize after a space
    if (oldValue.text.length < newValue.text.length &&
        oldValue.text.endsWith(" ")) {
      newText = newText.substring(0, newText.length - 1) +
          newText[newText.length - 1].toUpperCase();
    }

    return TextEditingValue(
      text: toBeginningOfSentenceCase(
          newText), // Capitalize first letter of each word
      selection: newValue.selection,
    );
  }
}
