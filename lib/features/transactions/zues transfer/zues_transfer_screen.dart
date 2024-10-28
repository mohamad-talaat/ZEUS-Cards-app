import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constant/app_styles.dart';
import '../../../core/constant/color.dart';
import '../../dashboard/appbar_widget.dart';
import '../../dashboard/ui/widget/button_name_and_pressed.dart';
import '../../full_auth/ui/widget/customtextformauth.dart';
import 'logic/data_service.dart';
import 'logic/zues_transfer_controller.dart';

class ZuesTransferScreen extends StatelessWidget {
  const ZuesTransferScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ZeusTransferController>(
      init: ZeusTransferController(zeusTransferService: ZeusTransferService()),
      builder: (controller) {
        return Scaffold(
          body: _buildForm(controller),
        );
      },
    );
  }

  Widget _buildForm(ZeusTransferController controller) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Form(
        key: controller.zeusTransferformKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 40.h),
              appBarWidget(
                  appBarTitle: "ZEUS Transfer",
                  style: AppTextStyle.appBarTextStyle.copyWith(fontSize: 20)),
              SizedBox(height: 50.h),
              CustomTextFormAuth(
                mycontroller: controller.cardCodeController,
                hinttext: "Sender Card Code",
                labeltext: "Sender Card Code",
                valid: (value) => value == null || value.isEmpty
                    ? 'Please Enter Sender Card Code'
                    : null,
                isNumber: true,
              ),
              SizedBox(height: 15.h),
              CustomTextFormAuth(
                mycontroller: controller.amountController,
                hinttext: "Enter amount in USD",
                labeltext: "Enter Amount ",
                valid: (value) => value == null || value.isEmpty
                    ? 'Please enter the amount'
                    : null,
                isNumber: true,
              ),
              SizedBox(height: 20.0.h),
              CustomTextFormAuth(
                mycontroller: controller.cardCodeToSendToController,
                hinttext: "Receiver Card Code",
                labeltext: "Receiver Card Code",
                valid: (value) => value == null || value.isEmpty
                    ? 'Please enter the receiver card code'
                    : null,
                isNumber: true,
              ),
              SizedBox(height: 25.0.h),
              Obx(
                () => submitButton(
                  child: controller.isLoading.value
                      ? const CircularProgressIndicator(
                          color: AppColor.white,
                          backgroundColor: AppColor.primaryColor)
                      : Text(
                          'Submit',
                          style: AppTextStyle.montserratSimiBold14White,
                        ),
                  onPressed: controller.isLoading.value ||
                          controller.isSubmitting.value
                      ? null // Disable the button if loading or submitting
                      : controller.submitTransfer,
                ),
              ),
              SizedBox(height: 32.0.h),
            ],
          ),
        ),
      ),
    );
  }
}
