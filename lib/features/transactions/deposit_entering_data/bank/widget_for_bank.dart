import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zeus/core/constant/app_styles.dart';
import 'package:zeus/core/constant/color.dart';

Widget staticDataForBank(Map<String, dynamic> cardData) {
  return Column(
    children: [
      staticCustomTextFormAuth(
        hinttext: cardData['beneficiary'] ?? "N/A",
        labeltext: "Beneficiary",
      ),
      staticCustomTextFormAuth(
        hinttext: cardData['IBAN'] ?? "N/A",
        labeltext: "IBAN",
      ),
      SizedBox(height: 10.0.h),
      staticCustomTextFormAuth(
        hinttext: cardData['BIC'] ?? "N/A",
        labeltext: "BIC",
      ),
      staticCustomTextFormAuth(
        hinttext: cardData['int_BIC'] ?? "N/A",
        labeltext: "Intermediary BIC",
      ),
      SizedBox(height: 10.0.h),
      staticCustomTextFormAuth(
        hinttext: cardData['address'] ?? "N/A",
        labeltext: "Beneficiary Address",
      ),
      SizedBox(height: 10.0.h),
      staticCustomTextFormAuth(
        hinttext: cardData['inst'] ?? "N/A",
        labeltext: "Bank/Payment Institution",
      ),
      SizedBox(height: 10.0.h),
      staticCustomTextFormAuth(
        hinttext: cardData['inst_address'] ?? "N/A",
        labeltext: "Bank/Payment Institution Address",
      ),
    ],
  );
}

Widget staticCustomTextFormAuth({
  required String hinttext,
  required String labeltext,
}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 6.w),
    margin: const EdgeInsets.only(bottom: 10),
    // width: 200.w,
    child: TextFormField(
      readOnly: true,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,

        hintText: hinttext,
        hintMaxLines: 2,
        hintStyle: AppTextStyle.montserratSimiBold14Black
            .copyWith(color: AppColor.grey, fontSize: 12),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: const EdgeInsets.symmetric(vertical: 2, horizontal: 30),
        label: Container(
            margin: const EdgeInsets.symmetric(horizontal: 5),
            child: Text(labeltext,
                style: AppTextStyle.montserratSimiBold14Black
                    .copyWith(fontSize: 15))),

        // border:
        //     OutlineInputBorder(borderRadius: BorderRadius.circular(30))
      ),
    ),
  );
}

Widget messageWidget(
    {required String first,
    required String second,
    required String amountControllerr}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
    child: Text(
      "$first$amountControllerr$second ",
      style: const TextStyle(
        color: AppColor.primaryColor,
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
