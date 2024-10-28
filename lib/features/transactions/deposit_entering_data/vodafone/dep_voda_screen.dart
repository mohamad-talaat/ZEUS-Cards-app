import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zeus/core/constant/app_styles.dart';
import 'package:zeus/core/constant/color.dart';
import 'package:zeus/features/dashboard/appbar_widget.dart';
import 'package:zeus/features/dashboard/ui/widget/button_name_and_pressed.dart';
import 'package:zeus/features/full_auth/ui/widget/customtextformauth.dart';
import 'package:zeus/features/transactions/deposit_entering_data/vodafone/logic/dep_voda_logic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// vodafone_cash_deposit_screen.dart
class VodafoneCashDepositScreen extends GetView<VodafoneCashDepositController> {
  const VodafoneCashDepositScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(VodafoneCashDepositController());

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: controller.formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 24.h),
                appBarWidget(
                    leftPadding: 15.0,
                    appBarTitle: 'Deposit Via Vodafone Cash',
                    style: AppTextStyle.appBarTextStyle.copyWith(fontSize: 15)),
                SizedBox(
                  height: 30.h,
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
                  height: 10.h,
                ),
                Obx(() => Center(
                      child: Text(
                        'Deposit rate: ${controller.depositRate.value} EGP + 8%',
                        style: TextStyle(
                            color: AppColor.primaryColor,
                            fontSize: 14.w,
                            fontWeight: FontWeight.bold),
                      ),
                    )),

                SizedBox(
                  height: 10.h,
                ),
                CustomTextFormAuth(
                  hinttext: 'Enter Amount. Minimum 35 USD',
                  labeltext: 'Amount',
                  mycontroller: controller.amountController,
                  valid: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the amount';
                    }
                    if ( //double.tryParse(value) == null &&
                        double.tryParse(value)! < 35) {
                      return 'Value must be greater than or equal to 35';
                    }
                    return null;
                  },
                  isNumber: true,
                ),

                Obx(() => Center(
                      child: Text(
                        'You need to pay ${controller.calculatedAmount.value.toStringAsFixed(2)} EGP to ZEUS V-Cash Wallet',
                        style: TextStyle(
                            color: AppColor.primaryColor,
                            fontSize: 13.w,
                            fontWeight: FontWeight.bold),
                      ),
                    )),

                SizedBox(
                  height: 15.h,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: TextFormField(
                    readOnly: true,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText:
                            // ignore: unnecessary_string_interpolations
                            "01029252953",
                        hintStyle: AppTextStyle.montserratSimiBold14Black
                            .copyWith(
                                color: Colors.grey,
                                fontWeight: FontWeight.w300),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 30),
                        label: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 9),
                            child: Text("ZEUS Vodafone Cash Wallet Number ",
                                style: AppTextStyle
                                    .montserratSimiBold14BlackForLabelText))),

                    // border:
                    //     OutlineInputBorder(borderRadius: BorderRadius.circular(30))
                  ),
                ),

                /////////////////////////////////////////////
                SizedBox(height: 30.h),
                buttonForImageUpload(
                    buttonTitle: 'Upload Transfer Copy',
                    onPressed: controller.pickInvoice),
                const SizedBox(height: 8),
                Obx(() => Row(
                      children: [
                        controller.invoicePath.isEmpty
                            ? const Text(
                                'No file selected',
                                style: TextStyle(
                                    color: Colors.redAccent,
                                    fontWeight: FontWeight.bold),
                              )
                            : Expanded(
                              child: Text(
                                  'File selected: ${controller.invoicePath.split('/').last}',
                                style: const TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold),
                              ),),
                      ],
                    )),

                SizedBox(height: 30.h),
                /////////////////////////////////////////////////////
                CustomTextFormAuth(
                  hinttext: 'Your V-Cash Wallet Number ',
                  labeltext: 'number',
                  mycontroller: controller.invoiceNumberController,
                  valid: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the  V-Cash Wallet Number ';
                    }
                    return null;
                  },
                  isNumber: true,
                ),

                // SizedBox(height: 20.h),

                // Obx(() => Text(
                //       'You need to pay in EGP: ${controller.calculatedAmount.value.toStringAsFixed(2)}',
                //       style: const TextStyle(
                //           color: AppColor.primaryColor,
                //           fontSize: 16,
                //           fontWeight: FontWeight.bold),
                //     )),
                const SizedBox(height: 24),

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
