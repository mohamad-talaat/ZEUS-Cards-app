import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:zeus/core/constant/app_styles.dart';
import 'package:zeus/core/constant/color.dart';
import 'package:zeus/features/dashboard/appbar_widget.dart';
import 'package:zeus/features/dashboard/ui/widget/button_name_and_pressed.dart';
import 'package:zeus/features/full_auth/ui/widget/customtextformauth.dart';
import 'package:zeus/features/transactions/deposit_entering_data/bank/widget_for_bank.dart';
import 'logic/dep_bank_logic.dart';

// vodafone_cash_deposit_screen.dart

class DepositBankTransferScreen extends GetView<BankDepositController> {
  const DepositBankTransferScreen({super.key});

  @override
  Widget build(BuildContext context) {
    BankDepositController controller = Get.put(BankDepositController());
    // final RxDouble calculatedAmount = 0.0.obs;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(10.h),
        child: Form(
          key: controller.formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 24.h),
                appBarWidget(
                    appBarTitle: 'Deposit Via Bank Transfer',
                    leftPadding: 15,
                    style: AppTextStyle.appBarTextStyle.copyWith(fontSize: 15)),
                SizedBox(
                  height: 10.h,
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
                CustomTextFormAuth(
                  hinttext: 'Enter Amount. Minimum 10 USD',
                  labeltext: 'Amount',
                  mycontroller: controller.amountController,
                  valid: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the amount';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Please enter a valid number';
                    }
                    if ( //double.tryParse(value) == null &&
                        double.tryParse(value)! < 10) {
                      return 'Value must be greater than or equal to 10';
                    }
                    return null;
                  },
                  isNumber: true,
                ),
                SizedBox(
                  height: 10.h,
                ),
                CustomTextFormAuth(
                  hinttext: 'Transfer Reference ',
                  labeltext: 'Transfer Reference ',
                  mycontroller: controller.invoiceNumberController,
                  valid: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter The Transfer Reference ';
                    }
                    return null;
                  },
                  isNumber: true,
                ),

                // Obx(() => Text(
                //       "Please transfer ${controller.amountControllerr} to your card dedicated account below Bank transfer",
                //       style: const TextStyle(
                //         color: AppColor.primaryColor,
                //         fontSize: 16,
                //         fontWeight: FontWeight.bold,
                //       ),
                //     )),

                Obx(() => messageWidget(
                    first: "Please transfer ",
                    second: "\$ to your card dedicated account below ",
                    amountControllerr: "${controller.amountControllerr}")),

                SizedBox(height: 15.h),
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
                SizedBox(height: 10.h),
                Obx(() => staticDataForBank(controller.cardData.value)),

                //   staticDataForBank(),
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
