import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:zeus/core/constant/app_styles.dart';
import 'package:zeus/core/pagescall/pagename.dart';
import 'package:zeus/features/dashboard/ui/widget/to_update_balance.dart';
import 'package:zeus/features/transactions/deposit_entering_data/platform/logic/choose_platform_logic.dart';
import 'package:zeus/features/transactions/withdraw_entering_data/usdt/logic/with_usdt_data_service.dart';
import 'package:zeus/features/transactions/withdraw_entering_data/usdt/with_usdt_model.dart';

class USDTwithdrawController extends GetxController {
  final WithdrawUSDTService withdrawUSDTService =
      Get.find<WithdrawUSDTService>();
  final formKey = GlobalKey<FormState>();
  final RxBool isLoading = false.obs;
  final PlatformController platformController = Get.put(PlatformController());

  final List<String> platformOptions = [
    'Binance',
    'Bybit'
  ]; // Available platforms
  final RxString selectedPlatform = ''.obs; // Store selected platform as string

  final cardCodeController = TextEditingController();
  final amountController = TextEditingController();
  // final userPlatformIdController = TextEditingController();
  final platformChoiseController = TextEditingController();
  final plaformUserIdController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    Get.put(PlatformController()); // Initialize PlatformController
    platformController.fetchPlatforms(); // Fetch platforms immediately
    // ... your other initialization code
  }

  Future<void> submitUSDTwithdraw() async {
    if (formKey.currentState!.validate()) {
      try {
        isLoading.value = true;
        // int platformId = selectedPlatform.value == 'Binance' ? 1 : 2;

        final request = USDTWithdrawRequest(
          cardCode: cardCodeController.text.trim(),
          price: amountController.text.trim(),
          userPlatformId: plaformUserIdController.text.trim(),
          platform: platformController.selectedPlatformName.value
              .toString(), // Send platform ID as a string
        );

        final response = await withdrawUSDTService.submitUSDTWithdraw(request);

        if (response.result) {
          Get.defaultDialog(
              titleStyle: AppTextStyle.successWordInmassegeInGetDialog,
              title: "Success",
              confirm: TextButton(
                onPressed: () async {
                  // Clear the form fields after successful submission
                  cardCodeController.clear();
                  amountController.clear();
                  platformChoiseController.clear();

                  plaformUserIdController.clear();
                  Get.toNamed(PageName.bottomNavBar);
                  // Update data in the background
                  await updateAppOnSuccess();
                },
                child: Text(
                  "Ok",
                  style: AppTextStyle.appBarTextStyle.copyWith(fontSize: 15),
                ),
              ),
              content: Text(
                  style: AppTextStyle.paypalRegular11,
                  "Withdrawal request is submitted\nplease check your email in the next 30 minutes to confirm your transaction\nWithdrawal fees: 2%\nCredit duration is one working day"));
          ('USDT withdrawal submitted successfully');
        } else {
          Get.snackbar('Error', response.msg);
          (response.msg);
        }
      } catch (e) {
        Get.snackbar('Error',
            'Failed to submit USDT withdrawal: ${e.toString() == "type 'Null' is not a subtype of type 'bool'" ? "\n1-Your Card Code Not Found \n 2-check Your balance" : "Please Check You Data"}');
      } finally {
        isLoading.value = false;
      }
    }
  }

  @override
  void onClose() {
    cardCodeController.dispose();
    amountController.dispose();

    platformChoiseController.dispose();
    plaformUserIdController.dispose();
    super.onClose();
  }
}
