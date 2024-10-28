import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zeus/core/constant/app_styles.dart';
import 'package:zeus/features/dashboard/appbar_widget.dart';
import 'package:zeus/features/dashboard/ui/widget/button_name_and_pressed.dart';
import 'package:zeus/features/full_auth/ui/widget/customtextformauth.dart';
import 'package:zeus/features/transactions/withdraw_entering_data/vodafone/logic/vod_with_logic.dart';
import '../../../../core/constant/color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VodafoneCashWithDrawScreen
    extends GetView<VodafoneCashwithdrawController> {
  const VodafoneCashWithDrawScreen({super.key});

  @override
  Widget build(BuildContext context) {
    VodafoneCashwithdrawController controller =
        Get.put(VodafoneCashwithdrawController());
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: controller.formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 25.h,
                ),
                appBarWidget(
                    appBarTitle: 'Withdraw Via Vodafone Cash',
                    leftPadding: 15.0,
                    style: AppTextStyle.appBarTextStyle.copyWith(fontSize: 14)),
                SizedBox(
                  height: 40.h,
                ),
                CustomTextFormAuth(
                    hinttext: "Card Code",
                    labeltext: "Card Code",
                    mycontroller: controller.cardCodeController,
                    valid: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your Card Code';
                      }

                      return null;
                    },
                    isNumber: true),
                const SizedBox(
                  height: 5,
                ),
                Obx(() => Center(
                      child: Text(
                        'Withdraw rate: ${controller.withdrawRate.value} EGP',
                        style: TextStyle(
                            color: AppColor.primaryColor,
                            fontSize: 16.w,
                            fontWeight: FontWeight.bold),
                      ),
                    )),
                const SizedBox(
                  height: 15,
                ),
                CustomTextFormAuth(
                    hinttext: "Enter Amount. Minimum 25 USD",
                    labeltext: "Amount",
                    mycontroller: controller.amountController,
                    valid: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the amount';
                      }
                      if ( //double.tryParse(value) == null &&
                          double.tryParse(value)! < 25) {
                        return 'Value must be greater than or equal to 25';
                      }
                      return null;
                    },
                    isNumber: true),
                SizedBox(height: 10.h),
                CustomTextFormAuth(
                    hinttext: "Vodafone Cash Wallet",
                    labeltext: "Your Vodafone Cash Wallet Number",
                    mycontroller: controller.vodafoneNumberController,
                    valid: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the amount';
                      }
                      return null;
                    },
                    isNumber: true),
                SizedBox(height: 20.h),
                Obx(() => Center(
                      child: Text(
                        'You Will get in EGP: ${controller.calculatedAmount.value.toStringAsFixed(2)}',
                        style: const TextStyle(
                            color: AppColor.primaryColor,
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      ),
                    )),
                SizedBox(height: 25.0.h),
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
                          : controller.submitVodafoneCashwithdraw,
                    )),
                SizedBox(height: 32.0.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
