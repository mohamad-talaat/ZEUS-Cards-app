import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import 'package:zeus/core/constant/app_styles.dart';
import 'package:zeus/core/constant/color.dart';

import 'package:zeus/features/dashboard/appbar_widget.dart';
import 'package:zeus/features/transactions/deposit_entering_data/bank/widget_for_bank.dart';
import 'package:zeus/features/transactions/deposit_entering_data/platform/logic/choose_platform_logic.dart';
import 'package:zeus/features/dashboard/ui/widget/button_name_and_pressed.dart';
import 'package:zeus/features/full_auth/ui/widget/customtextformauth.dart';
import 'package:zeus/features/transactions/deposit_entering_data/platform/logic/choose_platform_service_model.dart';
import 'package:zeus/features/transactions/deposit_entering_data/usdt/logic/dep_via_usdt_logic.dart';

// vodafone_cash_deposit_screen.dart

class USDTDepositScreen extends GetView<USDTDepositController> {
  const USDTDepositScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(USDTDepositController());
    PlatformController platformController = Get.put(PlatformController());
    PlatformService platformser = Get.put(PlatformService());
    Get.put(PlatformController());

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: controller.formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 30.h),
                appBarWidget(appBarTitle: 'Deposit Via USDT'),
                const SizedBox(
                  height: 50,
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
                const SizedBox(
                  height: 14,
                ),
                CustomTextFormAuth(
                  hinttext: 'Enter Amount. Minimum 15 USDT',
                  labeltext: 'Amount',
                  mycontroller: controller.amountController,
                  valid: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the amount';
                    }
                    if ( //double.tryParse(value) == null &&
                        double.tryParse(value)! < 15) {
                      return 'Value must be greater than or equal to 15';
                    }
                    return null;
                  },
                  isNumber: true,
                ),
                const SizedBox(
                  height: 5,
                ),

                // Obx(
                //   () => ExpansionTile(
                //     backgroundColor: Colors.white,
                //     title: Row(
                //       children: [
                //         const Text(
                //           'Selected Platform: ',
                //         ),
                //         Text(
                //           style: AppTextStyle.montserratSimiBold14Black
                //               .copyWith(
                //                   fontWeight: FontWeight.bold,
                //                   color: AppColor.primaryColor),
                //           ' ${platformController.selectedPlatformId.value == 0 ?
                //           "None" : platformController.platforms.firstWhere((element) =>
                //           element.id == platformController.selectedPlatformId.value).
                //           platform ?? "N/A"}',
                //         ),
                //       ],
                //     ),
                //     children: [
                //       Container(
                //         color: Colors.white, // Set background to white
                //         child: ListView.builder(
                //           padding: const EdgeInsets.only(bottom: 10),
                //           shrinkWrap: true,
                //           physics: const NeverScrollableScrollPhysics(),
                //           itemCount: platformController.platforms.length,
                //           itemBuilder: (context, index) {
                //             final platform =
                //                 platformController.platforms[index];
                //             return ListTile(
                //               title: Text(platform.platform,
                //                   style: AppTextStyle
                //                       .montserratSimiBold14Black
                //                       .copyWith(
                //                           fontWeight: FontWeight.bold,
                //                           color: AppColor.primaryColor)),
                //               onTap: () {
                //                 platformController.selectedPlatformId
                //                     .value = platform.id;
                //               },
                //             );
                //           },
                //         ),
                //       ),
                //     ],
                //   ),
                // ),

                Obx(() => (Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                      ),
                      child: DropdownButtonFormField<int>(
                        //   padding: EdgeInsets.only(top: ),
                        value: platformController.selectedPlatformId.value == 0
                            ? null // Set initial value to null
                            : platformController.selectedPlatformId.value,
                        focusColor: Colors.white,
                        dropdownColor: Colors.white,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    const BorderSide(color: AppColor.grey)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    const BorderSide(color: AppColor.grey)),
                            hintStyle: const TextStyle(fontSize: 14),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 30),
                            label: Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 9),
                                child: Text('Select Platform',
                                    style: AppTextStyle
                                        .montserratSimiBold14Black))),
                        items: platformController.platforms.map((platform) {
                          return DropdownMenuItem<int>(
                            value: platform
                                .id, // Display platform name, use ID as value
                            child: Text(
                              platform.platform,
                              style: AppTextStyle.appBarTextStyle
                                  .copyWith(fontSize: 14),
                            ),
                          );
                        }).toList(),
                        onChanged: (platformId) {
                          platformController.selectedPlatformId.value =
                              platformId!;
                          int codeIndex =
                              platformController.selectedPlatformId.value;

                          if (codeIndex >= 1 &&
                              codeIndex <= platformser.platformCode.length) {
                            controller.plaformUserIdController.text =
                                platformser.platformCode[codeIndex - 1]
                                    .toString();
                          } else {
                            controller.plaformUserIdController.clear();
                          }
                        },
                      ),
                    ))),
                const SizedBox(
                  height: 25,
                ),
                Obx(
                  () => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: TextFormField(
                      readOnly: true,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText:
                              // ignore: unnecessary_string_interpolations
                              "${platformController.selectedPlatformId.value == 1 ? "416768225" : "146209149"}",
                          hintStyle: AppTextStyle.montserratSimiBold14Black,
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 30),
                          label: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 9),
                              child: Text(" ZEUS Platform ID",
                                  style: AppTextStyle
                                      .montserratSimiBold14BlackForLabelText))),

                      // border:
                      //     OutlineInputBorder(borderRadius: BorderRadius.circular(30))
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                CustomTextFormAuth(
                  hinttext: 'Transfer Reference ',
                  labeltext: 'Transfer Reference ',
                  mycontroller: controller.invoiceNumberController,
                  valid: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the Transfer Reference ';
                    }
                    return null;
                  },
                  isNumber: true,
                ),

                Obx(() => messageWidget(
                    first: "Please transfer ",
                    second: " to ZEUS Platform ID",
                    amountControllerr: "${controller.amountControllerr} USDT")),
                const SizedBox(height: 16),

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
                                    fontSize: 10,
                                    color: Colors.redAccent,
                                    fontWeight: FontWeight.bold),
                              )
                            :Expanded(
                              child: Text(
                                  'File selected: ${controller.invoicePath.split('/').last}',
                                style: const TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold),
                              ),),
                      ],
                    )),
                const SizedBox(height: 24),

                Obx(() => submitButton(
                      child: controller.isLoading.value
                          ? const CircularProgressIndicator(
                              color: AppColor.white,
                              backgroundColor: AppColor.primaryColor,
                            )
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
