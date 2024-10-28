import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:zeus/core/constant/app_styles.dart';
import 'package:zeus/core/constant/color.dart';
import 'package:zeus/features/dashboard/appbar_widget.dart';
import 'package:zeus/features/dashboard/ui/widget/button_name_and_pressed.dart';
import 'package:zeus/features/full_auth/ui/widget/customtextformauth.dart';
import 'package:zeus/features/transactions/deposit_entering_data/payment%20link/logic/paym_link_logic.dart';

// Payment_Link_deposit_screen.dart

class PaymentLinkDepositScreen extends GetView<PaymentLinkDepositController> {
  const PaymentLinkDepositScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(PaymentLinkDepositController());
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: controller.formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 60.h),
                appBarWidget(
                    leftPadding: 15.0,
                    appBarTitle: 'Deposit Via Payment Link',
                    style: AppTextStyle.appBarTextStyle.copyWith(fontSize: 15)),
                SizedBox(
                  height: 70.h,
                ),
                CustomTextFormAuth(
                  hinttext: 'Enter Card Code',
                  labeltext: 'Card Code',
                  mycontroller: controller.cardCodeController,
                  valid: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the card code';
                    }
                    return null;
                  },
                  isNumber: true,
                ),
                SizedBox(
                  height: 30.h,
                ),
                CustomTextFormAuth(
                  hinttext: 'Enter Amount. Minimum 25 EUR',
                  labeltext: 'Enter Amount',
                  mycontroller: controller.amountController,
                  valid: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the amount';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Please enter a valid number';
                    }
                    if ( //double.tryParse(value) == null &&
                        double.tryParse(value)! < 25) {
                      return 'Value must be greater than or equal to 25';
                    }
                    return null;
                  },
                  isNumber: true,
                ),
                SizedBox(
                  height: 30.h,
                ),
                Obx(() => submitButton(
                      child: controller.isLoading.value
                          ? const CircularProgressIndicator(
                              color: AppColor.white,
                              backgroundColor: AppColor.primaryColor)
                          : Text(
                              'Submit',
                              style: AppTextStyle.montserratSimiBold14White,
                            ),
                      onPressed: controller.isLoading.value
                          ? null
                          : controller.submitDeposit,
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
