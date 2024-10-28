import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zeus/core/constant/app_styles.dart';
import 'package:zeus/core/constant/color.dart';
import 'package:zeus/features/dashboard/appbar_widget.dart';
import 'package:zeus/features/transactions/deposit_entering_data/platform/logic/choose_platform_logic.dart';
import 'package:zeus/features/dashboard/ui/widget/button_name_and_pressed.dart';
import 'package:zeus/features/full_auth/ui/widget/customtextformauth.dart';
import 'package:zeus/features/transactions/deposit_entering_data/platform/logic/choose_platform_service_model.dart';
import 'package:zeus/features/transactions/withdraw_entering_data/usdt/logic/with_usdt_data_service.dart';
import 'package:zeus/features/transactions/withdraw_entering_data/usdt/logic/with_usdt_logic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WithdrawUSDTPage extends GetView<USDTwithdrawController> {
  const WithdrawUSDTPage({super.key});

  @override
  Widget build(BuildContext context) {
    USDTwithdrawController controller = Get.put(USDTwithdrawController());
    Get.put(WithdrawUSDTService());
    final PlatformController platformController = Get.put(PlatformController());
    Get.put(PlatformService());

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: controller.formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 20.h),
                  appBarWidget(
                      appBarTitle: 'Withdraw Via USDT',
                      leftPadding: 15.0,
                      style:
                          AppTextStyle.appBarTextStyle.copyWith(fontSize: 17)),
                  SizedBox(
                    height: 30.h,
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
                  SizedBox(height: 10.0.h),
                  CustomTextFormAuth(
                      hinttext: "Enter Amount. Minimum 5 USD",
                      labeltext: "Amount",
                      mycontroller: controller.amountController,
                      valid: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the amount';
                        }
                        if (double.tryParse(value) == null) {
                          return 'Please enter a valid number';
                        }
                        if ( //double.tryParse(value) == null &&
                            double.tryParse(value)! < 5) {
                          return 'Value must be greater than or equal to 5';
                        }
                        return null;
                      },
                      isNumber: true),
                  SizedBox(height: 7.0.h),
                  Obx(
                    () => Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: DropdownButtonFormField<String>(
                        // Use String for both value and items
                        value: platformController
                                .selectedPlatformName.value.isNotEmpty
                            ? platformController.selectedPlatformName.value
                            : null,
                        focusColor: Colors.white,
                        dropdownColor: Colors.white,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: AppColor.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: AppColor.grey),
                          ),
                          hintStyle: const TextStyle(fontSize: 14),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 30),
                          label: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 9),
                            child: Text(
                              'Select Platform',
                              style: AppTextStyle.montserratSimiBold14Black,
                            ),
                          ),
                        ),
                        items: platformController.platforms.map((platform) {
                          return DropdownMenuItem<String>(
                            value:
                                platform.platform, // Use platform name as value
                            child: Text(
                              platform.platform,
                              style: AppTextStyle.appBarTextStyle
                                  .copyWith(fontSize: 14),
                            ),
                          );
                        }).toList(),
                        onChanged: (platformName) {
                          // Update the selected platform name
                          platformController.selectedPlatformName.value =
                              platformName!;
                          ("  $platformName");

                          // Find the corresponding platform code
                          int codeIndex = platformController.platforms
                              .indexWhere((element) =>
                                  element.platform == platformName);
                          if (codeIndex != -1) {
                            controller.plaformUserIdController.text =
                                platformController.platforms[codeIndex].code;
                            controller.plaformUserIdController.clear();
                          } else {
                            controller.plaformUserIdController.clear();
                          }
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                  CustomTextFormAuth(
                      hinttext: " Enter Your Binance or Bybit ID ",
                      labeltext: "Your ID",
                      mycontroller: controller.plaformUserIdController,
                      valid: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the ID';
                        }
                        return null;
                      },
                      isNumber: true),
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
                            : controller.submitUSDTwithdraw,
                      )),
                  SizedBox(height: 32.0.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
